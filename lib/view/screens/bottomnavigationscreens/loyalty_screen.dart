import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:Marouf/models/balance_history.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/my_rewards_screen.dart';
import 'package:Marouf/view/widgets/loyalty_loading_widget.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/viewmodel/loyalty_viewmodel.dart';

import '../../../main.dart';
import '../../../utils/constant/assets_constant.dart';
import '../../../utils/theme/app_theme.dart';
import '../../widgets/branch_loading_widgte.dart';
import '../signin_screen.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoyaltyViewModel>(
      init: LoyaltyViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme:
          const IconThemeData(color: AppTheme.colorPrimaryDark),
          title: Text('myPoint'.tr,
              style: const TextStyle(color: AppTheme.colorPrimaryDark)),
        ),
        body: !controller.isLogin
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'notRegisterUser'.tr,
                  style: AppTheme.boldStyle(color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * .4,
                child: InkWell(
                  onTap: () {
                    NavigationApp.offUntil(SigninScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.colorAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'register'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
            : controller.isLoading
            ? const LoyaltyLoadingWidget()
            : SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AssetsConstant.logo,
                width: Get.width*.5,
                height: Get.height * .25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                          "${'myPoint'.tr} ${controller.userLoyalty.balance!} ${'points'.tr}",
                          style: AppTheme.lightStyle(
                              color: AppTheme.colorAccent,
                              size: 18.sp)),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Image.asset(
                      //     AssetsConstant.pointSchema,
                      //     height: 25,
                      //   ),
                      // ),
                    ],
                  ),
                  Center(
                    child: Text(
                        "${'myBalance'.tr} ${(controller.userLoyalty.balance!) / 100} ${controller.userLoyalty.currencyDisplayName!}",
                        style: AppTheme.lightStyle(
                            color: AppTheme.colorPrimary,
                            size: 18.sp)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              builder: (BuildContext context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: Get.height * .3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            color: Colors.transparent),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15),
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform: appLanguage=='ar'? Matrix4.rotationY(pi):Matrix4.rotationY(0),
                                                child: Image.asset(
                                                  AssetsConstant.popup,
                                                  width: double.infinity,
                                                  height: Get.height * .3,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 30,
                                              right: 30,
                                              top: 0,
                                              bottom: 0,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(height:20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                'spend'
                                                                    .tr,
                                                                style: AppTheme
                                                                    .lightStyle(
                                                                  color: AppTheme
                                                                      .bottomNavColor,
                                                                  size:
                                                                  20.sp,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Text(
                                                                'earn'.tr,
                                                                style: AppTheme
                                                                    .lightStyle(
                                                                  color:AppTheme.bottomNavColor,
                                                                  size:
                                                                  20.sp,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      Expanded(
                                                          child:
                                                          Container())
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${controller.userLoyalty.addConvertionData!.equivalentCashAmountPerUnit!} ${controller.userLoyalty.currencyDisplayName!}',
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              '='.tr,
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              '${controller.userLoyalty.addConvertionData!.numberOfPoints!} ${'points'.tr}',
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                        Container(),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                'redeemed'
                                                                    .tr,
                                                                style: AppTheme
                                                                    .lightStyle(
                                                                  color: AppTheme.bottomNavColor,
                                                                  size:
                                                                  20.sp,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                ' ',
                                                                style: AppTheme
                                                                    .boldStyle(
                                                                  color: AppTheme
                                                                      .colorPrimaryDark,
                                                                  size:
                                                                  14.sp,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      Expanded(
                                                          child:
                                                          Container())
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${controller.userLoyalty.redeemConvertionData!.numberOfPoints} ${'points'.tr}',
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              '='.tr,
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              '${controller.userLoyalty.redeemConvertionData!.equivalentCashAmountPerUnit} ${controller.userLoyalty.currencyDisplayName}',
                                                              style: AppTheme
                                                                  .lightStyle(
                                                                color: AppTheme.bottomNavColor,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                        Container(),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppTheme.colorAccent),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text('pointSchema'.tr,
                                    style: AppTheme.boldStyle(
                                        color: Colors.white,
                                        size: 16.sp)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 12,
                    // ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       NavigationApp.to(RedemptionRewardsScreen(
                    //           controller.userLoyalty.balance!));
                    //     },
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(16),
                    //       child: Container(
                    //         decoration: const BoxDecoration(
                    //             color: AppTheme.colorPrimary),
                    //         child: Center(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(20.0),
                    //             child: Text('rewardsGallery'.tr,
                    //                 style: AppTheme.boldStyle(
                    //                     color: Colors.white, size: 18)),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${'redeemed'.tr}  ${controller.userLoyalty.redeemedPoints!}",
                            style: AppTheme.boldStyle(
                                color: Colors.black, size: 16.sp)),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AssetsConstant.redeemed,
                              height: 25,
                              color: AppTheme.colorPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${'expired'.tr}  ${controller.userLoyalty.expiredPoints!}",
                            style: AppTheme.boldStyle(
                                color: Colors.black, size: 16.sp)),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AssetsConstant.expired,
                              height: 25,
                              color: AppTheme.colorPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              PagedListView<int, UserBalanceHistoryModel>(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<
                    UserBalanceHistoryModel>(
                  firstPageProgressIndicatorBuilder: (context) =>
                  const BranchLoadingWidget(),
                  noItemsFoundIndicatorBuilder: (context) =>
                      NoItemsWidget(
                        img: AssetsConstant.noReward,
                        title: 'emptyHistory'.tr,
                        isSmall: true,
                      ),
                  newPageProgressIndicatorBuilder: (context) =>
                  const BranchLoadingWidget(),
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(getRewardsTitle(item),
                                  style: AppTheme.boldStyle(
                                      color: Colors.black,
                                      size: 14.sp)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${'earnDate'.tr}:',
                                style: AppTheme.boldStyle(
                                    color: Colors.black,
                                    size: 12.sp)),
                            Text(
                                ' ${DateFormat('yyyy-MM-dd  hh:mm a').format(DateTime.parse(item.creationDate!))}',
                                style: AppTheme.lightStyle(
                                    color: Colors.black,
                                    size: 12.sp)),
                          ],
                        ),
                        if (item.expiryDate != null)
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${'expiryDate'.tr}:',
                                  style: AppTheme.boldStyle(
                                      color: Colors.black,
                                      size: 12.sp)),
                              Text(
                                  ' ${DateFormat('yyyy-MM-dd  hh:mm a').format(DateTime.parse(item.expiryDate!))}',
                                  style: AppTheme.lightStyle(
                                      color: Colors.black,
                                      size: 12.sp)),
                            ],
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.grey.shade400,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getRewardsTitle(UserBalanceHistoryModel item) {
    String title = '';
    switch (item.triggerType) {
      case 8:
        title =
        '${'receivedFrom'.tr} ${item.senderName} ( + ${item.numberOfPoints} ${'points'.tr} ) ';
        break;
      case 9:
        title =
        '${'transferredTo'.tr} ${item.receiverMobileNumber} ( - ${item.numberOfPoints} ${'points'.tr} ) ';
        break;
      case 2:
      case 11:
      case 14:
      case 15:
        title = '${item.source!} ( - ${item.numberOfPoints} ${'points'.tr} )';
        break;
      default:
        title = '${item.source!} ( + ${item.numberOfPoints} ${'points'.tr} )';
        break;
    }
    return title;
  }
}
