import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:Marouf/main.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:Marouf/viewmodel/order_details_viewmodel.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../widgets/loding_history_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsViewModel>(
        init: OrderDetailsViewModel(orderId),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (fromNotification == false) {
                return true;
              } else {
                Get.offAll(MainScreen(),
                    duration: const Duration(seconds: 1),
                    transition: Transition.fadeIn);
                return false;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: BackButton(
                  onPressed: () {
                    if (fromNotification == false) {
                      Get.back();
                    } else {
                      Get.offAll(MainScreen(),
                          duration: const Duration(seconds: 1),
                          transition: Transition.fadeIn);
                    }
                  },
                ),
                title: Text('orderStatus'.tr,
                    style: AppTheme.boldStyle(color: Colors.black, size: 20)),
              ),
              body: controller.isLoading
                  ? Column(
                      children: const [
                        LoadingHistoryCard(),
                        LoadingHistoryCard(),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.all(4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${'orderId'.tr}: ${controller.orderDetails.id}',
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 16)),
                                          if (controller
                                                  .orderDetails.deliveryDate !=
                                              null)
                                            Text(
                                                '${'orderDate'.tr}: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(controller.orderDetails.creationDate!).add(const Duration(hours: 3))).replaceAll('AM', 'am'.tr).replaceAll('PM', 'pm'.tr)}',
                                                style: AppTheme.lightStyle(
                                                    color: Colors.black,
                                                    size: 16)),
                                          if (controller
                                              .orderDetails.isScheduled!)
                                          Text(
                                              '${'deliveryDate'.tr}: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(controller.orderDetails.deliveryDate!)).replaceAll('AM', 'am'.tr).replaceAll('PM', 'pm'.tr)}'
                                              ,style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 16)),
                                          Text(
                                              '${'orderStatus'.tr}: ${getStatus(controller.orderDetails.status!)[0].tr}',
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 16)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        getStatus(
                                            controller.orderDetails.status!)[1],
                                        width: 50,
                                        color:AppTheme.colorPrimary
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.orderDetails.orderItems!.length,
                            itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: Get.height*.15,
                                          width: Get.width*.25,
                                          child: CachedNetworkImage(
                                            imageUrl: controller.orderDetails
                                                    .orderItems![index].url ??
                                                '',
                                            placeholder: (w, e) => Image.asset(
                                              AssetsConstant.loading,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (c, e, s) => Image.asset(
                                                AssetsConstant.placeHolder),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 1.0),
                                                  child: Text(
                                                    controller
                                                        .orderDetails
                                                        .orderItems![index]
                                                        .name!,
                                                    style: AppTheme.boldStyle(
                                                        color: Colors.black,
                                                        size: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            height: 2,
                                            color: Colors.grey.shade200,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('oneItemPrice'.tr),
                                              controller
                                                          .orderDetails
                                                          .orderItems![index]
                                                          .offerPrice! >
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .orderDetails
                                                              .orderItems![
                                                                  index]
                                                              .price!
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: AppTheme
                                                                  .colorAccent),
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                            controller
                                                                .orderDetails
                                                                .orderItems![
                                                                    index]
                                                                .offerPrice!
                                                                .toStringAsFixed(
                                                                    2),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                      ],
                                                    )
                                                  : Text(controller.orderDetails
                                                      .orderItems![index].price!
                                                      .toStringAsFixed(2)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('quantity'.tr),
                                              Text(
                                                  '${controller.orderDetails.orderItems![index].quantity!}'),
                                            ],
                                          ),
                                          if (controller
                                              .orderDetails
                                              .orderItems![index]
                                              .orderItemOptions!
                                              .isNotEmpty)
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller
                                                      .orderDetails
                                                      .orderItems![index]
                                                      .orderItemOptions!
                                                      .length,
                                                  itemBuilder:
                                                      (context, optionIndex) =>
                                                          Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${controller.orderDetails.orderItems![index].orderItemOptions![optionIndex].name!}'),
                                                      controller
                                                                  .orderDetails
                                                                  .orderItems![
                                                                      index]
                                                                  .orderItemOptions![
                                                                      optionIndex]
                                                                  .unitPrice! >
                                                              0
                                                          ? Text(
                                                              '${controller.orderDetails.orderItems![index].orderItemOptions![optionIndex].unitPrice!.toStringAsFixed(2)}')
                                                          : Text(''),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                              ],
                                            ),
                                          Container(
                                            height: 2,
                                            color: Colors.grey.shade200,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('totalPrice'.tr),
                                              Text(
                                                  '${controller.orderDetails.orderItems![index].totalPriceWithOptionItemsPrices!.toStringAsFixed(2)}'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text('subTotal'.tr,
                                            style: AppTheme.lightStyle(
                                                color: Colors.black, size: 18)),
                                      ),
                                      Text(
                                          '${controller.orderDetails.subTotalAmount!.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                          style: AppTheme.lightStyle(
                                              color: Colors.black, size: 18)),
                                    ],
                                  ),
                                  Visibility(
                                    visible: (controller.orderDetails
                                                    .discountAmount ??
                                                0) >
                                            0
                                        ? true
                                        : false,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text('discountAmount'.tr,
                                                  style: AppTheme.lightStyle(
                                                      color: Colors.red,
                                                      size: 18)),
                                            ),
                                            Text(
                                                '${controller.discountPromo.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                                style: AppTheme.lightStyle(
                                                    color: Colors.red,
                                                    size: 18)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text('tax'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 18)),
                                        ),
                                        Text(
                                            '${controller.orderDetails.tax.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                            style: AppTheme.lightStyle(
                                                color: Colors.black, size: 18)),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text('tax'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 18)),
                                        ),
                                        Text(
                                            '${controller.discountPrice!.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                            style: AppTheme.lightStyle(
                                                color: Colors.black, size: 18)),
                                      ],
                                    ),
                                  ),
                                  if (double.parse(controller
                                          .orderDetails.brandDiscount
                                          .toString()) >
                                      0)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text('discount'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.red, size: 18)),
                                        ),
                                        Text(
                                            '${controller.orderDetails.brandDiscount!.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                            style: AppTheme.lightStyle(
                                                color: Colors.red, size: 18)),
                                      ],
                                    ),
                                  if (controller
                                          .orderDetails.redemptionAmount !=
                                      0.0)
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text('redeemed'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.red, size: 18)),
                                        ),
                                        Text(
                                            '${controller.orderDetails.redemptionAmount!.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                            style: AppTheme.lightStyle(
                                                color: Colors.red, size: 18)),
                                      ],
                                    ),
                                  // if(controller.orderDetails.brandDiscount!=0.0)
                                  //   Row(
                                  //     mainAxisSize: MainAxisSize.max,
                                  //     mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Expanded(
                                  //         child: Text('discount'.tr,
                                  //             style: AppTheme.lightStyle(
                                  //                 color: Colors.red, size: 18)),
                                  //       ),
                                  //       Text(
                                  //           '${controller.orderDetails.brandDiscount} ${controller.orderDetails.currencyAbbreviation}',
                                  //           style: AppTheme.lightStyle(
                                  //               color: Colors.red, size: 18)),
                                  //     ],
                                  //   ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text('deliveryFee'.tr,
                                            style: AppTheme.lightStyle(
                                                color: Colors.black, size: 18)),
                                      ),
                                      controller.orderDetails.deliveryFees == 0.0
                                          ? Text('free'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black,
                                                  size: 18))
                                          : Text(
                                              '${controller.orderDetails.deliveryFees!.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                              style: AppTheme.lightStyle(color: Colors.black, size: 18).copyWith(
                                                  decoration: ((controller
                                                                      .orderDetails
                                                                      .deliveryFeesOfferPrice !=
                                                                  null ||
                                                              (controller.orderDetails
                                                                          .deliveryFeesOfferPrice ??
                                                                      0.0) >
                                                                  0.0) &&
                                                          controller
                                                                  .orderDetails
                                                                  .deliveryFees! >
                                                              0)
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none)),
                                      if ((controller.orderDetails
                                                      .deliveryFeesOfferPrice !=
                                                  null ||
                                              (controller.orderDetails
                                                          .deliveryFeesOfferPrice ??
                                                      0.0) >
                                                  0.0) &&
                                          controller
                                                  .orderDetails.deliveryFees! >
                                              0)
                                        Text(
                                            '  ${(controller.orderDetails.deliveryFeesOfferPrice ?? 0.0).toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                            style: AppTheme.lightStyle(
                                                color: Colors.red, size: 18)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text('taxDesc'.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTheme.lightStyle(
                                                color: AppTheme.colorAccent,
                                                size: 14.sp)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 2,
                                    color: Colors.grey.shade400,
                                  ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.max,
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Expanded(
                                  //       child: Text('taxDescTwo'.tr,
                                  //           textAlign: TextAlign.center,
                                  //           style: AppTheme.lightStyle(
                                  //               color: AppTheme.colorPrimary,
                                  //               size: 12.sp)),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  // Container(
                                  //   height: 2,
                                  //   color: Colors.grey.shade400,
                                  // ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text('finalAmount'.tr,
                                            style: AppTheme.boldStyle(
                                                color: Colors.black, size: 18)),
                                      ),
                                      Text(
                                          '${controller.orderDetails.totalAmount.toStringAsFixed(2)} ${controller.orderDetails.currencyAbbreviation}',
                                          style: AppTheme.boldStyle(
                                              color: AppTheme.colorAccent,
                                              size: 18)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  List<String> getStatus(int statusId) {
    switch (statusId) {
      case 0:
        return ['pendingForPayment', AssetsConstant.pendingPayment, 'false'];
      case 1:
        return ['orderReceived', AssetsConstant.pendingForReview, 'false'];
      case 2:
        return ['approved', AssetsConstant.orderISCocked, 'false'];
      case 3:
        return ['inProgress', AssetsConstant.orderISCocked, 'false'];
      case 4:
        return ['onItsWay', AssetsConstant.deliverIcon, 'false'];
      case 5:
        return ['orderIsCanceled', AssetsConstant.orderCanceled, 'false'];
      case 6:
        return ['orderComplete', AssetsConstant.closed, 'true'];
      case 10:
        return ['failedPayment', AssetsConstant.failedPayment, 'false'];
      default:
        return ['unknown'];
    }
  }
}
