import 'dart:convert';
import 'dart:developer';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:Marouf/viewmodel/cart_viewmodel.dart';
import 'package:Marouf/viewmodel/my_addresses_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../models/branche_model.dart';
import '../../models/cart_model.dart';
import '../../models/user_address.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/date_time_picker_widget.dart';
import '../widgets/no_items_widget.dart';
import 'address_map_screen.dart';
import 'cart_screen.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);
  final addressShakeKey = GlobalKey<ShakeWidgetState>();
  final paymentShakeKey = GlobalKey<ShakeWidgetState>();

  double taxValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(CartScreen());
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ValueListenableBuilder<List<CartItem>>(
          valueListenable: cartList,
          builder:
              (BuildContext context, List<CartItem> cartItems, Widget? child) {
            return GetBuilder<CartViewModel>(
                init: CartViewModel(cartItems),
                builder: (controller) => GetBuilder<MyAddressesViewModel>(
                      init: MyAddressesViewModel(
                          cartViewModel: controller, isCartAddress: true),
                      builder: (controllerAddress) => Scaffold(
                        appBar: AppBar(
                          leading: BackButton(
                            onPressed: () {
                              Get.offAll(CartScreen());
                            },
                          ),
                          centerTitle: false,
                          iconTheme:
                              const IconThemeData(color: AppTheme.colorAccent),
                          title: Text('checkOut'.tr,
                              style: AppTheme.boldStyle(
                                  color: AppTheme.colorAccent, size: 16.sp)),
                        ),
                        bottomNavigationBar: cartItems.isEmpty
                            ? Container(
                                height: 0,
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Helper().actionDialog(
                                            'cancleOrder'.tr,
                                            'cancleCartbody'.tr,
                                            confirm: () {
                                              SharedPreferences.getInstance()
                                                  .then((prefs) {
                                                prefs.setStringList(
                                                    SharedPreferencesKey.cart,
                                                    []);
                                                cartList.value = cartFromJson(
                                                    "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
                                                Get.back();
                                              });
                                            },
                                            cancel: () {
                                              Get.back();
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                          child: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.delete_forever,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (!controller.isProcessed) {
                                              controller.isProcessed = true;
                                              controller.update();
                                              print(controllerAddress
                                                  .selectedAddress);
                                              if (controllerAddress
                                                      .selectedAddress ==
                                                  null) {
                                                controller.isProcessed = false;
                                                controller.update();
                                                Scrollable.ensureVisible(
                                                    addressShakeKey
                                                        .currentContext!);
                                                addressShakeKey.currentState
                                                    ?.shake();
                                                Helper().errorSnackBar(
                                                    "selectYourAddress".tr);
                                              } else if (controller.orderTime ==
                                                      'later' &&
                                                  controller.orderDate ==
                                                      null) {
                                                controller.isProcessed = false;
                                                controller.update();
                                                Helper().errorSnackBar(
                                                    "selectDeliveryDate".tr);
                                              } else if (controller
                                                      .paymentType ==
                                                  '') {
                                                controller.isProcessed = false;
                                                controller.update();

                                                Helper().errorSnackBar(
                                                    "selectPaymentMethod".tr);
                                              } else {
                                                controller.isProcessed = true;
                                                controller.update();

                                                controller.login(() {
                                                  Map<String, dynamic> body =
                                                      {};
                                                  var listItems = [];
                                                  for (var element
                                                      in cartItems) {
                                                    Map<String, dynamic>
                                                        itemJson = {
                                                      "CategoryId":
                                                          "${int.parse(element.itemCategoryId!) != 0 ? int.parse(element.itemCategoryId!) : 1}",
                                                      "BrandId":
                                                          "${int.parse(element.itemBrandId!)}",
                                                      "ItemID":
                                                          "${int.parse(element.itemId!)}",
                                                      "Quantity":
                                                          "${int.parse(element.itemQuantity!)}",
                                                      "PriceId":
                                                          "${int.parse(element.itemPriceId!)}",
                                                      "SpecialInstructions":
                                                          "${element.itemInstructions}",
                                                    };
                                                    if (element.productProperties !=
                                                            null &&
                                                        element
                                                            .productProperties!
                                                            .isNotEmpty) {
                                                      var productProperties =
                                                          [];
                                                      element.productProperties!
                                                          .forEach((element1) {
                                                        productProperties.add(
                                                            element1.toJson());
                                                      });
                                                      body.putIfAbsent(
                                                          'ProductProperties',
                                                          () =>
                                                              productProperties);
                                                    }

                                                    var optionsList = [];

                                                    if (element.hasOptions ==
                                                        'true') {
                                                      if (element.itemOptions
                                                              ?.isNotEmpty ??
                                                          false) {
                                                        for (var option
                                                            in element
                                                                .itemOptions!) {
                                                          var optionJson = {
                                                            "OptionId":
                                                                "${int.parse(option.optionParentId!)}",
                                                            "ProductOptionItemId":
                                                                "${int.parse(option.optionId!)}",
                                                            "Quantity": 1,
                                                            "OptionPrice":
                                                                "${option.optionPrice!}"
                                                          };
                                                          optionsList
                                                              .add(optionJson);
                                                        }
                                                      }
                                                    }
                                                    itemJson.putIfAbsent(
                                                        'OrderItemOptions',
                                                        () => optionsList);
                                                    listItems.add(itemJson);
                                                  }

                                                  body.putIfAbsent('OrderItems',
                                                      () => listItems);
                                                  body.putIfAbsent(
                                                      'ShippingAddressId',
                                                      () => controllerAddress
                                                          .selectedAddress!.id);
                                                  body.putIfAbsent(
                                                      'SpecialInstructions',
                                                      () => controller
                                                          .instructionsController
                                                          .text);
                                                  body.putIfAbsent(
                                                      'OrderDeliveryMethod',
                                                      () => 1);
                                                  body.putIfAbsent(
                                                      'ShippingAddressId',
                                                      () => controllerAddress
                                                          .selectedAddress!.id);

                                                  if (controller
                                                              .promoModel !=
                                                          null &&
                                                      controller.promoModel!
                                                              .promotionCodeStatus ==
                                                          4) {
                                                    body.putIfAbsent(
                                                        "PromotionType",
                                                        () => controller
                                                            .promoModel!
                                                            .promotionType);
                                                    body.putIfAbsent(
                                                        "PromotionCode",
                                                        () => controller
                                                            .promoController
                                                            .text
                                                            .trim());
                                                  } else if (controller
                                                              .promoModel !=
                                                          null &&
                                                      (controller.promoModel!
                                                                  .promotionCodeStatus ==
                                                              11 ||
                                                          controller.promoModel!
                                                                  .promotionCodeStatus ==
                                                              5) &&
                                                      controller.promoTrue) {
                                                    body.putIfAbsent(
                                                        "PromotionType",
                                                        () => controller
                                                            .promoModel!
                                                            .promotionType);
                                                    body.putIfAbsent(
                                                        "PromotionCode",
                                                        () => controller
                                                            .promoController
                                                            .text
                                                            .trim());
                                                  }

                                                  if (controller.promoModel !=
                                                      null) {
                                                    if (controller.promoModel!
                                                            .promotionType ==
                                                        0) {
                                                      var promoPercentage =
                                                          controller.promoModel!
                                                                  .value! /
                                                              100;
                                                      body.putIfAbsent(
                                                          "DiscountAmount",
                                                          () => controller
                                                              .promoModel!
                                                              .value!);
                                                    } else if (controller
                                                            .promoModel!
                                                            .promotionType ==
                                                        1) {
                                                      body.putIfAbsent(
                                                          "DiscountAmount",
                                                          () => controller
                                                              .promoModel!
                                                              .value!);
                                                    }
                                                  }
                                                  if (controller.isPoint) {
                                                    body.putIfAbsent(
                                                        "DeductFromBalance",
                                                        () => true);
                                                  }
                                                  if (controller.finalAmount !=
                                                      0) {
                                                    body.putIfAbsent(
                                                        "PaymentsType",
                                                        () => controller
                                                            .paymentTypIde);
                                                    // if (IS_PAYMENT_ONLINE) {
                                                    //   body.putIfAbsent("ShopperUrl", () => 'thetammam://com.mozaic.www.maroufcoffee);
                                                    // }
                                                  } else {
                                                    // PaymentType = 1;
                                                    body.putIfAbsent(
                                                        "PaymentsType",
                                                        () => controller
                                                            .paymentTypIde);
                                                  }
                                                  if (controller.orderTime ==
                                                      'later') {
                                                    body.putIfAbsent(
                                                        "DeliveryDate",
                                                        () => DateFormat(
                                                                'yyyy-MM-dd HH:mm')
                                                            .parse(controller
                                                                .orderDate!
                                                                .toString())
                                                            .toString());
                                                  }
                                                  if (controller.hasDiscount) {
                                                    body.putIfAbsent(
                                                        "DeliveryFeesDiscount",
                                                        () => controller
                                                            .deliveryFeesDiscount);
                                                    body.putIfAbsent(
                                                        "DeliveryFeesDiscountId",
                                                        () => controller
                                                            .orderSetup!
                                                            .deliveryFeesDiscounts![
                                                                0]
                                                            .id);
                                                  }
                                                  // if (wrapGift.isChecked()) {
                                                  //   item.put("HasGiftWrapping", true);
                                                  // } else {
                                                  //   item.put("HasGiftWrapping", false);
                                                  // }

                                                  controller.checkout(body);
                                                  print(json.encode(body));
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller.isProcessed
                                                    ? Colors.grey
                                                    : AppTheme.colorPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10000)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text('OrderNow'.tr,
                                                    style: AppTheme.boldStyle(
                                                        color: Colors.white,
                                                        size: 16.sp)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                        body: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: controller.isCartLoading
                              ? SizedBox(
                                  height: Get.height * .9,
                                  child: const Center(
                                    child: const CircularProgressIndicator(),
                                  ),
                                )
                              : Column(
                                  children: [
                                    ValueListenableBuilder<List<CartItem>>(
                                      valueListenable: cartList,
                                      builder: (BuildContext context,
                                          List<CartItem> cartItems,
                                          Widget? child) {
                                        return cartItems.isEmpty
                                            ? GestureDetector(
                                                onTap: () {},
                                                child: NoItemsWidget(
                                                    hasColor: false,
                                                    img: AssetsConstant.noCart,
                                                    title: 'emptyCart'.tr,
                                                    body: ''),
                                              )
                                            : controller.isCartLoading
                                                ? const Center(
                                                    child:
                                                        const CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'addressDelivery'
                                                                    .tr,
                                                                style: AppTheme
                                                                    .lightStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            15)),
                                                          ],
                                                        ),
                                                      ),
                                                      ShakeWidget(
                                                        key: addressShakeKey,
                                                        shakeOffset: 10,
                                                        shakeCount: 2,
                                                        shakeDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    800),
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          elevation: 2,
                                                          child: controllerAddress
                                                                  .isLoading
                                                              ? const CircularProgressIndicator()
                                                              : controllerAddress
                                                                      .myAddresses
                                                                      .isEmpty
                                                                  ? Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        NoItemsWidget(
                                                                          img: AssetsConstant
                                                                              .noAddresses,
                                                                          title:
                                                                              'noAddresses'.tr,
                                                                          isSmall:
                                                                              true,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            NavigationApp.to(AddressMapScreen(
                                                                              initialCamera: CameraPosition(
                                                                                target: controllerAddress.selectedPosition,
                                                                                zoom: 11.0,
                                                                              ),
                                                                              cartViewModel: controller,
                                                                              isEdit: false,
                                                                              isCart: true,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.add_circle_outline_rounded,
                                                                                  size: 40,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Text(
                                                                                  'addNewAddress'.tr,
                                                                                  style: AppTheme.boldStyle(color: Colors.black, size: 12.sp),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              DropdownButton<Addresses>(
                                                                            isExpanded:
                                                                                true,
                                                                            value:
                                                                                controllerAddress.selectedAddress,
                                                                            //   hint: Text('selectYourAddress'.tr),
                                                                            items:
                                                                                controllerAddress.myAddresses.map((Addresses? value) {
                                                                              return DropdownMenuItem<Addresses>(
                                                                                value: value,
                                                                                child: Text(
                                                                                  '${value!.name} (${value.cityName!}, ${value.address!}, ${value.buildingNumber ?? ''})',
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.fade,
                                                                                  softWrap: false,
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged:
                                                                                (_) {
                                                                              controllerAddress.selectedAddress = _;
                                                                              controller.getDeliveryFee(_!.id);
                                                                              controller.update();
                                                                            },
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              12,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 2,
                                                                                color: Colors.grey.shade200,
                                                                              ),
                                                                            ),
                                                                            Text('   ${'or'.tr}   '),
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 2,
                                                                                color: Colors.grey.shade200,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.delete<CartViewModel>();
                                                                            NavigationApp.to(AddressMapScreen(
                                                                              initialCamera: CameraPosition(
                                                                                target: controllerAddress.selectedPosition,
                                                                                zoom: 11.0,
                                                                              ),
                                                                              isEdit: false,
                                                                              cartViewModel: controller,
                                                                              isCart: true,
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.add_circle_outline_rounded,
                                                                                  size: 40,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Text(
                                                                                  'addNewAddress'.tr,
                                                                                  style: AppTheme.boldStyle(color: Colors.black, size: 14.sp),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                        ),
                                                      ),
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        elevation: 2,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                  child: Text(
                                                                    'paymentType'
                                                                        .tr,
                                                                    style: AppTheme.boldStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        size: 16
                                                                            .sp),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .itemCountDeliveryMethodList,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  RadioListTile<
                                                                      String>(
                                                                value:
                                                                    '${controller.orderSetup!.availablePaymentTypes![index].id}',
                                                                title: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      controller.orderSetup!.availablePaymentTypes![index].id == 1
                                                                          ? AssetsConstant
                                                                              .cashIcon
                                                                          : AssetsConstant
                                                                              .creditCardIcon,
                                                                      height:
                                                                          Get.height *
                                                                              .05,
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .height *
                                                                          .01,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "${controller.orderSetup!.availablePaymentTypes![index].name!.toLowerCase().tr}",
                                                                        style: AppTheme.boldStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            size: 14.sp),
                                                                      ),
                                                                    ),
                                                                    if (controller
                                                                            .orderSetup!
                                                                            .availablePaymentTypes![index]
                                                                            .id ==
                                                                        2)
                                                                      Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            AssetsConstant.visa,
                                                                            height:
                                                                                Get.height * .035,
                                                                          ),
                                                                          Image
                                                                              .asset(
                                                                            AssetsConstant.master,
                                                                            height:
                                                                                Get.height * .035,
                                                                          ),
                                                                        ],
                                                                      )
                                                                  ],
                                                                ),
                                                                groupValue:
                                                                    controller
                                                                        .paymentType,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                          .paymentType =
                                                                      value!;
                                                                  controller
                                                                          .paymentTypIde =
                                                                      controller
                                                                          .orderSetup!
                                                                          .availablePaymentTypes![
                                                                              index]
                                                                          .id!;
                                                                  controller
                                                                      .isOnlinePayment = controller
                                                                          .orderSetup!
                                                                          .availablePaymentTypes![
                                                                              index]
                                                                          .id ==
                                                                      2;
                                                                  print(
                                                                      'paymentType ${controller.paymentType}');
                                                                  controller
                                                                      .update();
                                                                },
                                                              ),
                                                            ),
                                                            // RadioListTile<String>(
                                                            //   selected: true,
                                                            //   value: 'cash',
                                                            //   title: Row(
                                                            //     children: [
                                                            //       Image.asset(
                                                            //         AssetsConstant.cashIcon,
                                                            //         height: Get.height * .05,
                                                            //       ),
                                                            //       SizedBox(
                                                            //         width: Get.height * .01,
                                                            //       ),
                                                            //       Expanded(
                                                            //         child: Text(
                                                            //           'cash'.tr,
                                                            //           style: AppTheme.boldStyle(
                                                            //               color: Colors.black,
                                                            //               size: 16),
                                                            //         ),
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            //   groupValue:
                                                            //       controller.paymentType,
                                                            //   onChanged: (value) {
                                                            //     controller.paymentType = value!;
                                                            //     controller.paymentTypIde = 1;
                                                            //
                                                            //     controller.isOnlinePayment =
                                                            //         false;
                                                            //     controller.update();
                                                            //   },
                                                            // ),
                                                            // RadioListTile<String>(
                                                            //   value: 'credit',
                                                            //   title: Row(
                                                            //     children: [
                                                            //       Image.asset(
                                                            //         AssetsConstant
                                                            //             .creditCardIcon,
                                                            //         height: Get.height * .05,
                                                            //       ),
                                                            //       SizedBox(
                                                            //         width: Get.height * .01,
                                                            //       ),
                                                            //       Expanded(
                                                            //         child: Text(
                                                            //           'creditCard'.tr,
                                                            //           style: AppTheme.boldStyle(
                                                            //               color: Colors.black,
                                                            //               size: 16),
                                                            //         ),
                                                            //       ),
                                                            //       Image.asset(
                                                            //         AssetsConstant.visa,
                                                            //         height: Get.height * .035,
                                                            //       ),
                                                            //       Image.asset(
                                                            //         AssetsConstant.master,
                                                            //         height: Get.height * .035,
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            //   groupValue:
                                                            //       controller.paymentType,
                                                            //   onChanged: (value) {
                                                            //     controller.paymentType = value!;
                                                            //     controller.isOnlinePayment =
                                                            //         true;
                                                            //     controller.paymentTypIde = 2;
                                                            //     controller.update();
                                                            //
                                                            //   },
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        elevation: 2,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                  child: Text(
                                                                    'specialInstructions'
                                                                        .tr,
                                                                    style: AppTheme.boldStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        size: 16
                                                                            .sp),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 2,
                                                                controller:
                                                                    controller
                                                                        .instructionsController,
                                                                decoration: InputDecoration(
                                                                    hintText:
                                                                        'specialInstructions'
                                                                            .tr),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      if (controller.orderSetup!
                                                          .supportScheduleOrder!)
                                                        Card(
                                                          key: controller
                                                              .scheduleDateKey,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          elevation: 2,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: Text(
                                                                      'orderTime'
                                                                          .tr,
                                                                      style: AppTheme.boldStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          size:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          12.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.orderTime =
                                                                                'now';
                                                                            controller.update();
                                                                          },
                                                                          child: AnimatedContainer(
                                                                              duration: const Duration(milliseconds: 500),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(1000),
                                                                                color: controller.orderTime == 'now' ? Colors.black : Colors.white,
                                                                                border: Border.all(color: Colors.black),
                                                                              ),
                                                                              child: Center(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'now'.tr,
                                                                                    style: AppTheme.lightStyle(color: controller.orderTime == 'now' ? Colors.white : Colors.black, size: 20),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.orderTime =
                                                                                'later';
                                                                            controller.getScheduleTimes();
                                                                            controller.update();
                                                                          },
                                                                          child: AnimatedContainer(
                                                                              duration: const Duration(milliseconds: 500),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(1000),
                                                                                color: controller.orderTime == 'later' ? Colors.black : Colors.white,
                                                                                border: Border.all(color: Colors.black),
                                                                              ),
                                                                              child: Center(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'later'.tr,
                                                                                    style: AppTheme.lightStyle(color: controller.orderTime == 'later' ? Colors.white : Colors.black, size: 20),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              if (controller
                                                                      .orderTime ==
                                                                  'later')
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Wrap(
                                                                            children: [
                                                                              FittedBox(
                                                                                fit: controller.orderDate != null ? BoxFit.fitWidth : BoxFit.none,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(12.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        '${'orderTime'.tr}:',
                                                                                        style: AppTheme.lightStyle(color: Colors.black, size: Get.width * .04),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 8,
                                                                                      ),
                                                                                      Text(
                                                                                        controller.orderDate != null ? intl.DateFormat('yyyy-MM-dd hh:mm a').format(controller.orderDate!).toLowerCase().replaceAll('am', 'am'.tr).replaceAll('pm', 'pm'.tr) : '',
                                                                                        style: AppTheme.lightStyle(color: Colors.black, size: Get.width * .04),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              TextEditingController txt = TextEditingController();
                                                                              Get.bottomSheet(
                                                                                DateTimePickerWidget(controller),
                                                                                isScrollControlled: true,
                                                                              );
                                                                            },
                                                                            child: AnimatedContainer(
                                                                                duration: const Duration(milliseconds: 500),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(1000),
                                                                                  color: Colors.black,
                                                                                  border: Border.all(color: Colors.black),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 26.0),
                                                                                    child: Text(
                                                                                      controller.orderDate != null ? 'change'.tr : 'set'.tr,
                                                                                      style: AppTheme.lightStyle(color: Colors.white, size: 18),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      Visibility(
                                                        visible:
                                                        !((controller.orderSetup?.deliveryFeesDiscounts?[0].discountValue??0) > 0),
                                                        child: Card(
                                                          color: Get.theme.scaffoldBackgroundColor,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(16),
                                                          ),
                                                          elevation: 2,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.symmetric(
                                                                    horizontal: 12.0,
                                                                    vertical: 12),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: TextFormField(
                                                                        maxLines: 1,
                                                                        onEditingComplete: () {
                                                                          if (controller
                                                                              .promoController
                                                                              .text
                                                                              .isNotEmpty) {
                                                                            FocusScope.of(context)
                                                                                .unfocus();
                                                                            controller.checkPromo(
                                                                                controller
                                                                                    .promoController
                                                                                    .text
                                                                                    .trim());
                                                                          }
                                                                        },
                                                                        onChanged: (v) {
                                                                          controller.discountPromo = 0;
                                                                          controller.calculatePrices();
                                                                          controller.promoDone = false;
                                                                          controller.promoTrue = false;
                                                                          controller.errorText = '';
                                                                          controller.update();
                                                                        },
                                                                        controller: controller
                                                                            .promoController,
                                                                        textInputAction:
                                                                        TextInputAction.done,
                                                                        onFieldSubmitted:
                                                                            (value) {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                        },
                                                                        decoration:
                                                                        InputDecoration(
                                                                          helperText: controller
                                                                              .errorText
                                                                              .isNotEmpty
                                                                              ? controller
                                                                              .errorText
                                                                              : null,
                                                                          helperMaxLines: 2,
                                                                          helperStyle:
                                                                          AppTheme.lightStyle(
                                                                              color:
                                                                              AppTheme.colorAccent,
                                                                              size: 14),
                                                                          hintText:
                                                                          'promoCode'.tr,
                                                                          hintStyle: AppTheme
                                                                              .lightStyle(
                                                                            color: AppTheme.colorPrimary,
                                                                          ),
                                                                          suffixIcon: Column(
                                                                            mainAxisSize:
                                                                            MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                            children: [
                                                                              controller.isLoading
                                                                                  ? const CircularProgressIndicator()
                                                                                  : controller
                                                                                  .promoDone
                                                                                  ? controller
                                                                                  .promoTrue
                                                                                  ? Row(
                                                                                mainAxisSize:
                                                                                MainAxisSize.min,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      controller.discountPromo = 0;
                                                                                      controller.promoController.clear();
                                                                                      controller.calculatePrices();
                                                                                      controller.promoDone = false;
                                                                                      controller.promoTrue = false;
                                                                                      controller.errorText = '';
                                                                                      controller.update();
                                                                                      FocusScope.of(context).unfocus();
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                      child: Text(
                                                                                        'clear'.tr,
                                                                                        style: AppTheme.lightStyle(
                                                                                          color: AppTheme.colorPrimary,
                                                                                          size: 14,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.green,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                                  : Row(
                                                                                mainAxisSize:
                                                                                MainAxisSize.min,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      controller.discountPromo = 0;
                                                                                      controller.promoController.clear();
                                                                                      controller.calculatePrices();
                                                                                      controller.promoDone = false;
                                                                                      controller.promoTrue = false;
                                                                                      controller.errorText = '';
                                                                                      controller.update();
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                      child: Text(
                                                                                        'clear'.tr,
                                                                                        style: AppTheme.lightStyle(
                                                                                          color: AppTheme.colorAccent,
                                                                                          size: 16,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const Icon(
                                                                                    Icons.info_outline,
                                                                                    color: AppTheme.colorAccent,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                                  : GestureDetector(
                                                                                onTap:
                                                                                    () {
                                                                                  FocusScope.of(context)
                                                                                      .unfocus();
                                                                                  if (controller
                                                                                      .promoController
                                                                                      .text
                                                                                      .isNotEmpty) {
                                                                                    controller.checkPromo(controller.promoController.text.trim());
                                                                                  } else {
                                                                                    controller.errorText =
                                                                                        'promoMustFill'.tr;
                                                                                    controller.update();
                                                                                  }
                                                                                },
                                                                                child:
                                                                                Text(
                                                                                  'apply'
                                                                                      .tr,
                                                                                  style:
                                                                                  AppTheme.boldStyle(
                                                                                    color:
                                                                                    AppTheme.colorAccent,
                                                                                    size:
                                                                                    18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        elevation: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                        'subTotal'
                                                                            .tr,
                                                                        style: AppTheme
                                                                            .lightStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                  ),
                                                                  Text(
                                                                      '${controller.subTotal.toStringAsFixed(2)} ${controller.unitPrice}',
                                                                      style: AppTheme
                                                                          .lightStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                ],
                                                              ),
                                                              Visibility(
                                                                visible:
                                                                    (controller.orderSetup!.discount ??
                                                                                0) >
                                                                            0
                                                                        ? true
                                                                        : false,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                              'discountAmount'.tr,
                                                                              style: AppTheme.lightStyle(
                                                                                color: Colors.black,
                                                                              )),
                                                                        ),
                                                                        Text(
                                                                            '${controller.discountAmountPercent} %',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.black,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                              'discount'.tr,
                                                                              style: AppTheme.lightStyle(
                                                                                color: Colors.red,
                                                                              )),
                                                                        ),
                                                                        // todo +_+
                                                                        Text(
                                                                            '${controller.discountPrice!.toStringAsFixed(2)} ${controller.unitPrice}',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.red,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                              'grandTotal'.tr,
                                                                              style: AppTheme.lightStyle(
                                                                                color: Colors.black,
                                                                              )),
                                                                        ),
                                                                        Text(
                                                                            '${(controller.grandAmount ?? 0).toStringAsFixed(2)} ${controller.unitPrice}',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.black,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: false,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          'tax'
                                                                              .tr,
                                                                          style:
                                                                              AppTheme.lightStyle(
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                    ),
                                                                    Text(
                                                                        '${(controller.orderSetup!.tax! * controller.subTotal).toStringAsFixed(2)} ${cartItems.first.itemPriceUnit}',
                                                                        style: AppTheme
                                                                            .lightStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: controller
                                                                        .discountPromo >
                                                                    0,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                              'promoDiscount'.tr,
                                                                              style: AppTheme.lightStyle(
                                                                                color: Colors.red,
                                                                              )),
                                                                        ),
                                                                        Text(
                                                                            // todo
                                                                            '${controller.discountPromo.toStringAsFixed(2)} ${controller.unitPrice}',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.red,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          12,
                                                                    ),
                                                                    Container(
                                                                      height: 2,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade400,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          12,
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                              'total'.tr,
                                                                              style: AppTheme.lightStyle(
                                                                                color: Colors.black,
                                                                              )),
                                                                        ),
                                                                        Text(
                                                                            '${(controller.subTotal - controller.discountPromo).toStringAsFixed(2)} ${controller.unitPrice}',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.black,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                        'deliveryFee'
                                                                            .tr,
                                                                        style: AppTheme
                                                                            .lightStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                  ),
                                                                  Text(
                                                                      (() {
                                                                        if (controllerAddress.selectedAddress ==
                                                                            null) {
                                                                          controller.deliveryFee =
                                                                              0.0;
                                                                          return '${"selectYourAddress".tr}';
                                                                        }
                                                                        return '${controller.deliveryFee!.toStringAsFixed(2)} ${cartItems.first.itemPriceUnit}';
                                                                      }()),
                                                                      style: AppTheme
                                                                          .lightStyle(
                                                                        color: controllerAddress.selectedAddress ==
                                                                                null
                                                                            ? AppTheme.colorAccent
                                                                            : Colors.black,
                                                                      ).copyWith(
                                                                          decoration: (controller.hasDiscount && controller.deliveryFee! > 0)
                                                                              ? TextDecoration.lineThrough
                                                                              : TextDecoration.none)),
                                                                  if(controller.hasDiscount)
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(width: 8,),
                                                                          controller.hasDiscount && controller.deliveryFeesDiscount == 0?
                                                                          Text('free'.tr,style:
                                                                                    AppTheme.lightStyle(
                                                                                  color: Colors.red,
                                                                                ),):
                                                                    Text(
                                                                            (() {
                                                                              if (controllerAddress.selectedAddress == null) {
                                                                                controller.deliveryFee = 0.0;
                                                                                return '${"0.00"} ${cartItems.first.itemPriceUnit}';
                                                                              }
                                                                              return '${controller.deliveryFeesDiscount.toStringAsFixed(2)} ${cartItems.first.itemPriceUnit}';
                                                                            }()),
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.red,
                                                                            )),
                                                                        ],
                                                                      )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              if (controller
                                                                      .orderSetup!
                                                                      .userBalance! >
                                                                  0)
                                                                Container(
                                                                  height: 2,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                        'taxDesc'
                                                                            .tr,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: AppTheme.lightStyle(
                                                                            color:
                                                                                AppTheme.colorAccent,
                                                                            size: 12.sp)),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                height: 2,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                        'taxDescTwo'
                                                                            .tr,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: AppTheme.lightStyle(
                                                                            color:
                                                                                AppTheme.colorPrimary,
                                                                            size: 12.sp)),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              Container(
                                                                height: 2,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              if (controller
                                                                      .orderSetup!
                                                                      .userBalance! >
                                                                  0)
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Checkbox(
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize
                                                                                .shrinkWrap,
                                                                        value: controller
                                                                            .isPoint,
                                                                        fillColor:
                                                                            MaterialStateProperty.all(Colors
                                                                                .red),
                                                                        onChanged:
                                                                            (c) {
                                                                          controller.isPoint =
                                                                              c!;
                                                                          controller
                                                                              .calculatePrices();
                                                                          controller
                                                                              .update();
                                                                        }),
                                                                    Expanded(
                                                                        child: Text(
                                                                            '${'replaceAvailablePoints'.tr} (${controller.orderSetup!.userBalance!.toStringAsFixed(2)} ${controller.unitPrice})',
                                                                            style:
                                                                                AppTheme.lightStyle(
                                                                              color: Colors.red,
                                                                            ))),
                                                                    const SizedBox(
                                                                      width: 16,
                                                                    ),
                                                                    Text(
                                                                        controller.isPoint
                                                                            ? '${controller.pointsRedeemed.toStringAsFixed(2)} ${cartItems.first.itemPriceUnit}'
                                                                            : "      ",
                                                                        style: AppTheme
                                                                            .lightStyle(
                                                                          color:
                                                                              Colors.red,
                                                                        )),
                                                                  ],
                                                                ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                        'finalAmount'
                                                                            .tr,
                                                                        style: AppTheme.boldStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            size: 14.sp)),
                                                                  ),
                                                                  Text(
                                                                      '${controller.finalAmount.toStringAsFixed(2)} ${controller.unitPrice}',
                                                                      style: AppTheme.boldStyle(
                                                                          color: AppTheme
                                                                              .colorAccent,
                                                                          size:
                                                                              14.sp)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                    ],
                                                  );
                                      },
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
