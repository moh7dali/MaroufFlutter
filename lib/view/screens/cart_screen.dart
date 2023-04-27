import 'dart:convert';

import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/view/screens/product_screen.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/viewmodel/cart_viewmodel.dart';
import 'package:Marouf/viewmodel/my_addresses_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import '../../main.dart';
import '../../models/cart_model.dart';
import '../../models/products_model.dart';
import '../../models/user_address.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/date_time_picker_widget.dart';
import 'address_map_screen.dart';
import 'checkout_screen.dart';
import 'main_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final shakeKey = GlobalKey<ShakeWidgetState>();

  double taxValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                init: MyAddressesViewModel(cartViewModel: controller),
                builder: (controllerAddress) => Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    title: Text('cart'.tr,
                        style: AppTheme.boldStyle(
                            color: Colors.black, size: 16.sp)),
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
                                          shakeKey.currentContext!);
                                      shakeKey.currentState?.shake();
                                      Helper().errorSnackBar(
                                          "selectDeliveryDate".tr);
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
                                                    () =>
                                                    intl.NumberFormat(
                                                      "#0.00",
                                                    ).format(controller
                                                        .promoModel!
                                                        .value!));
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
                                          //   body.putIfAbsent("ShopperUrl", () => 'thetammam://com.mozaic.www.tamam);
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
                                    BorderRadius.circular(10000)),
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
                    child: Column(
                      children: [
                        ValueListenableBuilder<List<CartItem>>(
                          valueListenable: cartList,
                          builder: (BuildContext context,
                              List<CartItem> cartItems, Widget? child) {
                            return cartItems.isEmpty
                                ? GestureDetector(
                              onTap: () {},
                              child: NoItemsWidget(
                                hasColor: true,
                                  img: AssetsConstant.noCart,
                                  title: 'emptyCart'.tr,
                                  body: ''),
                            )
                                : controller.isCartLoading
                                ?  SizedBox(
                              height: Get.height*.9,
                                  child: Center(
                              child:
                               CircularProgressIndicator(),
                            ),
                                )
                                : Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('cartItems'.tr,
                                          style:
                                          AppTheme.boldStyle(
                                              color: Colors
                                                  .black,
                                              size: 14.sp)),
                                      GestureDetector(
                                        onTap: () {
                                          Helper().actionDialog(
                                            'clearCart'.tr,
                                            'clearCartbody'.tr,
                                            confirm: () {
                                              SharedPreferences
                                                  .getInstance()
                                                  .then((prefs) {
                                                prefs.setStringList(
                                                    SharedPreferencesKey
                                                        .cart,
                                                    []);
                                                cartList.value =
                                                    cartFromJson(
                                                        "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");

                                                Get.back();
                                              });
                                            },
                                            cancel: () {
                                              Get.back();
                                            },
                                          );
                                        },
                                        child: Text(
                                            'clearCart'.tr,
                                            style: AppTheme
                                                .lightStyle(
                                                color: Colors
                                                    .red,
                                                size: 14.sp)),
                                      ),
                                    ],
                                  ),
                                ),
                                cartListWidget(
                                    cartItems, controller),
                                SizedBox(
                                  height: 8,
                                ),
                                if (controller
                                    .alsoAddedProducts
                                    .productItems
                                    ?.isNotEmpty ??
                                    false)
                                  Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              'peopleAlsoAdded'
                                                  .tr,
                                              style: AppTheme
                                                  .lightStyle(
                                                  color: Colors
                                                      .black,
                                                  size:
                                                  13.sp)),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller
                                    .alsoAddedProducts
                                    .productItems
                                    ?.isNotEmpty ??
                                    false)
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection:
                                      Axis.horizontal,
                                      itemBuilder: (context,
                                          index) =>
                                          buildPeopleAlsoAddedItem(
                                              controller
                                                  .alsoAddedProducts
                                                  .productItems![index]),
                                      itemCount: controller
                                          .alsoAddedProducts
                                          .productItems
                                          ?.length,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('addressDelivery'.tr,
                                          style:
                                          AppTheme.lightStyle(
                                              color: Colors
                                                  .black,
                                              size: 15)),
                                    ],
                                  ),
                                ),
                                ShakeWidget(
                                  key: shakeKey,
                                  shakeOffset: 10,
                                  shakeCount: 2,
                                  shakeDuration: const Duration(
                                      milliseconds: 800),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
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
                                          'noAddresses'
                                              .tr,
                                          isSmall: true,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            NavigationApp.to(
                                                AddressMapScreen(
                                                  initialCamera:
                                                  CameraPosition(
                                                    target:
                                                    controllerAddress.selectedPosition,
                                                    zoom:
                                                    11.0,
                                                  ),
                                                  cartViewModel:
                                                  controller,
                                                  isEdit:
                                                  false,
                                                  isCart:
                                                  true,
                                                ));
                                          },
                                          child:
                                          Padding(
                                            padding: const EdgeInsets
                                                .all(
                                                20.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  size:
                                                  40,
                                                ),
                                                const SizedBox(
                                                  width:
                                                  8,
                                                ),
                                                Text(
                                                  'addNewAddress'
                                                      .tr,
                                                  style: AppTheme.boldStyle(
                                                      color: Colors.black,
                                                      size: 12.sp),
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
                                          const EdgeInsets
                                              .all(
                                              12.0),
                                          child: DropdownButton<
                                              Addresses>(
                                            isExpanded:
                                            true,
                                            value: controllerAddress
                                                .selectedAddress,
                                            //   hint: Text('selectYourAddress'.tr),
                                            items: controllerAddress
                                                .myAddresses
                                                .map((Addresses?
                                            value) {
                                              return DropdownMenuItem<
                                                  Addresses>(
                                                value:
                                                value,
                                                child:
                                                Text(
                                                  '${value!.name} (${value.cityName!}, ${value.address!}, ${value.buildingNumber ?? ''})',
                                                  maxLines:
                                                  2,
                                                  overflow:
                                                  TextOverflow.fade,
                                                  softWrap:
                                                  false,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged:
                                                (_) {
                                              controllerAddress
                                                  .selectedAddress = _;
                                              controller
                                                  .getDeliveryFee(
                                                  _!.id);
                                              controller
                                                  .update();
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                              Container(
                                                height:
                                                2,
                                                color: Colors
                                                    .grey
                                                    .shade200,
                                              ),
                                            ),
                                            Text(
                                                '   ${'or'.tr}   '),
                                            Expanded(
                                              child:
                                              Container(
                                                height:
                                                2,
                                                color: Colors
                                                    .grey
                                                    .shade200,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            NavigationApp.to(
                                                AddressMapScreen(
                                                  initialCamera:
                                                  CameraPosition(
                                                    target:
                                                    controllerAddress.selectedPosition,
                                                    zoom:
                                                    11.0,
                                                  ),
                                                  isEdit:
                                                  false,
                                                  cartViewModel:
                                                  controller,
                                                ));
                                          },
                                          child:
                                          Padding(
                                            padding: const EdgeInsets
                                                .all(
                                                20.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  size:
                                                  40,
                                                ),
                                                const SizedBox(
                                                  width:
                                                  8,
                                                ),
                                                Text(
                                                  'addNewAddress'
                                                      .tr,
                                                  style: AppTheme.boldStyle(
                                                      color: Colors.black,
                                                      size: 14.sp),
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(12.0),
                                            child: Text(
                                              'paymentType'.tr,
                                              style: AppTheme
                                                  .boldStyle(
                                                  color: Colors
                                                      .black,
                                                  size:
                                                  16.sp),
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
                                            RadioListTile<String>(
                                              value:
                                              '${controller.orderSetup!.availablePaymentTypes![index].id}',
                                              title: Row(
                                                children: [
                                                  Image.asset(
                                                    controller
                                                        .orderSetup!
                                                        .availablePaymentTypes![
                                                    index]
                                                        .id ==
                                                        1
                                                        ? AssetsConstant
                                                        .cashIcon
                                                        : AssetsConstant
                                                        .creditCardIcon,
                                                    height:
                                                    Get.height *
                                                        .05,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                    Get.height *
                                                        .01,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${controller.orderSetup!.availablePaymentTypes![index].name!.toLowerCase().tr}",
                                                      style: AppTheme
                                                          .boldStyle(
                                                          color: Colors
                                                              .black,
                                                          size: 14
                                                              .sp),
                                                    ),
                                                  ),
                                                  if (controller
                                                      .orderSetup!
                                                      .availablePaymentTypes![
                                                  index]
                                                      .id ==
                                                      2)
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          AssetsConstant
                                                              .visa,
                                                          height:
                                                          Get.height *
                                                              .035,
                                                        ),
                                                        Image.asset(
                                                          AssetsConstant
                                                              .master,
                                                          height:
                                                          Get.height *
                                                              .035,
                                                        ),
                                                      ],
                                                    )
                                                ],
                                              ),
                                              groupValue: controller
                                                  .paymentType,
                                              onChanged: (value) {
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
                                                    .isOnlinePayment =
                                                    controller
                                                        .orderSetup!
                                                        .availablePaymentTypes![
                                                    index]
                                                        .id ==
                                                        2;
                                                print(
                                                    'paymentType ${controller.paymentType}');
                                                controller.update();
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(12.0),
                                            child: Text(
                                              'specialInstructions'
                                                  .tr,
                                              style: AppTheme
                                                  .boldStyle(
                                                  color: Colors
                                                      .black,
                                                  size:
                                                  16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 12.0),
                                        child: TextFormField(
                                          maxLines: 2,
                                          controller: controller
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
                                  visible: !((controller
                                      .orderSetup
                                      ?.discount ??
                                      0) >
                                      0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          16),
                                    ),
                                    elevation: 2,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              12.0,
                                              vertical: 12),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child:
                                                TextFormField(
                                                  maxLines: 1,
                                                  onEditingComplete:
                                                      () {
                                                    if (controller
                                                        .promoController
                                                        .text
                                                        .isNotEmpty) {
                                                      FocusScope.of(
                                                          context)
                                                          .unfocus();
                                                      controller.checkPromo(controller
                                                          .promoController
                                                          .text
                                                          .trim());
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    controller
                                                        .promoDone =
                                                    false;
                                                    controller
                                                        .errorText = '';
                                                    controller
                                                        .update();
                                                  },
                                                  controller:
                                                  controller
                                                      .promoController,
                                                  textInputAction:
                                                  TextInputAction
                                                      .done,
                                                  onFieldSubmitted:
                                                      (value) {
                                                    FocusScope.of(
                                                        context)
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
                                                    helperMaxLines:
                                                    2,
                                                    helperStyle: AppTheme
                                                        .lightStyle(
                                                        color: Colors
                                                            .red,
                                                        size:
                                                        14),
                                                    hintText:
                                                    'promoCode'
                                                        .tr,
                                                    suffixIcon:
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize
                                                          .max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        controller
                                                            .isLoading
                                                            ? const CircularProgressIndicator()
                                                            : controller.promoDone
                                                            ? controller.promoTrue
                                                            ? Row(
                                                          mainAxisSize: MainAxisSize.min,
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
                                                                    color: Colors.red,
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
                                                          mainAxisSize: MainAxisSize.min,
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
                                                                    color: Colors.red,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.info_outline,
                                                              color: Colors.red,
                                                            ),
                                                          ],
                                                        )
                                                            : GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(context).unfocus();
                                                            if (controller.promoController.text.isNotEmpty) {
                                                              controller.checkPromo(controller.promoController.text.trim());
                                                            } else {
                                                              controller.errorText = 'promoMustFill'.tr;
                                                              controller.update();
                                                            }
                                                          },
                                                          child: Text(
                                                            'apply'.tr,
                                                            style: AppTheme.boldStyle(
                                                              color: AppTheme.colorPrimary,
                                                              size: 18,
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
                                                      ? Colors.red
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
                                          // Container(
                                          //   height: 2,
                                          //   color: Colors
                                          //       .grey
                                          //       .shade400,
                                          // ),
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
                                        // const SizedBox(
                                        //   height: 4,
                                        // ),
                                        // Row(
                                        //   mainAxisSize:
                                        //   MainAxisSize
                                        //       .max,
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment
                                        //       .center,
                                        //   children: [
                                        //     Expanded(
                                        //       child: Text(
                                        //           'taxDescTwo'
                                        //               .tr,
                                        //           textAlign:
                                        //           TextAlign
                                        //               .center,
                                        //           style: AppTheme.lightStyle(
                                        //               color:
                                        //               AppTheme.colorPrimary,
                                        //               size: 12.sp)),
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 12,
                                        // ),
                                        // Container(
                                        //   height: 2,
                                        //   color: Colors
                                        //       .grey
                                        //       .shade400,
                                        // ),
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
    );
  }

  Widget buildPeopleAlsoAddedItem(ProductItem productItem) {
    String image = productItem.url!;
    double price = productItem.productItemPrices![0].price;
    String mealCurrency =
    productItem.productItemPrices![0].currancyDisplayName!;

    return GestureDetector(
      onTap: () {
        print('productItem.id! ${productItem.id!}');
        Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: .956,
              child: ProductScreen(productItem.id!),
            ),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            barrierColor: AppTheme.colorAccent);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CachedNetworkImage(
                      height: Get.width * .4,
                      width: Get.width * .4,
                      fit: BoxFit.cover,
                      imageUrl: image),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    width: Get.width * .4,
                    padding: EdgeInsets.only(bottom: 4, top: 4),
                    alignment: AlignmentDirectional.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          price.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          mealCurrency,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartListWidget(List<CartItem> cartItems, CartViewModel controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        bool startPositionAdd = false;
        bool startPositionSub = false;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: cartItems[index].itemUrl ?? '',
                      placeholder: (w, e) => Image.asset(
                        AssetsConstant.loading,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (c, e, s) =>
                          Image.asset(AssetsConstant.placeHolder),
                      fit: BoxFit.cover,
                      width: Get.width * .2,
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    cartItems[index].itemName!.trim(),
                                    style: AppTheme.boldStyle(
                                        color: Colors.black, size: 13.sp),
                                  ),
                                ),
                              ),
                              if (cartItems[index].productProperties != null)
                                Container(
                                  height: Get.height * .03,
                                  width: Get.height * .03,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor.fromHex(cartItems[index]
                                          .productProperties![0]
                                          .value!)),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('oneItemPrice'.tr),
                              cartItems[index].itemOfferPrice! > 0
                                  ? Row(
                                children: [
                                  Text(
                                    cartItems[index]
                                        .itemPrice!
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        color: AppTheme.colorAccent),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                      cartItems[index]
                                          .itemOfferPrice!
                                          .toStringAsFixed(2),
                                      style: TextStyle(color: Colors.red)),
                                ],
                              )
                                  : Text(cartItems[index]
                                  .itemPrice!
                                  .toStringAsFixed(2)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('quantity'.tr),
                              Text('${cartItems[index].itemQuantity!}'),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          if (cartItems[index].itemOptions!.isNotEmpty)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 6,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartItems[index].itemOptions!.length,
                                  itemBuilder: (context, optionIndex) => Row(
                                    children: [
                                      Expanded(
                                          child: Text(cartItems[index]
                                              .itemOptions![optionIndex]
                                              .optionName!)),
                                      cartItems[index]
                                          .itemOptions![optionIndex]
                                          .optionPrice! >
                                          0
                                          ? Text(
                                          '${cartItems[index].itemOptions![optionIndex].optionPrice!.toStringAsFixed(2)}')
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('totalPrice'.tr),
                              Text(cartItems[index].itemTotalOfferPrice! > 0
                                  ? cartItems[index]
                                  .itemTotalOfferPrice!
                                  .toStringAsFixed(2)
                                  : cartItems[index]
                                  .itemTotalPrice!
                                  .toStringAsFixed(2)),
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
                          if (cartItems[index].itemInstructions != "")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('specialOrder'.tr),
                                Text(cartItems[index].itemInstructions!),
                              ],
                            ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Helper().actionDialog(
                            '${cartItems[index].itemName!.trim()}'.tr,
                            'clearOneItem'.tr,
                            confirm: () {
                              SharedPreferences.getInstance().then((prefs) {
                                List<String> cartListItem = prefs.getStringList(
                                    SharedPreferencesKey.cart) ??
                                    [];
                                cartListItem.removeAt(index);
                                prefs.setStringList(
                                    SharedPreferencesKey.cart, cartListItem);
                                cartList.value = cartFromJson(
                                    "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
                                controller.cartItems = cartList.value;
                                controller.calculatePrices();
                                controller.checkPromPrices();
                                Get.back();
                              });
                            },
                            cancel: () {
                              Get.back();
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: Get.width * .08,
                width: Get.width * .28,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)),
                        child: GestureDetector(
                          onTapDown: (details) {
                            startPositionAdd = true;
                            startPositionSub = false;
                            controller.update();
                          },
                          onTapUp: (details) {
                            cartItems[index].itemQuantity = int.parse(
                                cartItems[index].itemQuantity.toString()) +
                                1;
                            if (cartItems[index].itemOfferPrice! > 0) {
                              cartItems[index].itemTotalOfferPrice =
                                  double.parse(cartItems[index]
                                      .itemTotalOfferPrice
                                      .toString()) +
                                      double.parse(cartItems[index]
                                          .itemOfferPrice
                                          .toString());
                              cartItems[index].itemOptions!.forEach((element) {
                                cartItems[index].itemTotalOfferPrice =
                                    double.parse(
                                        cartItems[index]
                                            .itemTotalOfferPrice
                                            .toString()) +
                                        double.parse(
                                            element.optionPrice.toString());
                              });
                            } else {
                              cartItems[index].itemTotalPrice = double.parse(
                                  cartItems[index]
                                      .itemTotalPrice
                                      .toString()) +
                                  double.parse(
                                      cartItems[index].itemPrice.toString());
                              cartItems[index].itemOptions!.forEach((element) {
                                cartItems[index].itemTotalPrice = double.parse(
                                    cartItems[index]
                                        .itemTotalPrice
                                        .toString()) +
                                    double.parse(
                                        element.optionPrice.toString());
                              });
                            }
                            startPositionAdd = true;
                            controller.update();
                            Future.delayed(const Duration(milliseconds: 50),
                                    () {
                                  startPositionAdd = false;
                                  controller.update();
                                });
                            SharedPreferences.getInstance().then((prefs) {
                              List<String> cartListItem = prefs.getStringList(
                                  SharedPreferencesKey.cart) ??
                                  [];
                              print('cartListItem: $cartListItem');
                              cartListItem[index] =
                                  jsonEncode(cartItems[index].toJson());
                              prefs.setStringList(
                                  SharedPreferencesKey.cart, cartListItem);
                              cartListItem = prefs.getStringList(
                                  SharedPreferencesKey.cart) ??
                                  [];
                              print('cartListItem1: $cartListItem');
                              cartList.value = cartFromJson(
                                  "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
                              controller.checkPromPrices();
                              controller.calculatePrices();
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.add, color: AppTheme.colorAccent),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)),
                        child: GestureDetector(
                          onTapDown: (details) {
                            startPositionAdd = false;
                            startPositionSub = true;
                            controller.update();
                          },
                          onTapUp: (details) {
                            if (int.parse(
                                cartItems[index].itemQuantity.toString()) >
                                1) {
                              cartItems[index].itemQuantity = int.parse(
                                  cartItems[index]
                                      .itemQuantity
                                      .toString()) -
                                  1;
                              if (cartItems[index].itemOfferPrice! > 0) {
                                cartItems[index].itemTotalOfferPrice =
                                    double.parse(
                                        cartItems[index]
                                            .itemTotalOfferPrice
                                            .toString()) -
                                        double.parse(cartItems[index]
                                            .itemOfferPrice
                                            .toString());
                                cartItems[index]
                                    .itemOptions!
                                    .forEach((element) {
                                  cartItems[index].itemTotalOfferPrice =
                                      double.parse(cartItems[index]
                                          .itemTotalOfferPrice
                                          .toString()) -
                                          double.parse(
                                              element.optionPrice.toString());
                                });
                              } else {
                                cartItems[index].itemTotalPrice = double.parse(
                                    cartItems[index]
                                        .itemTotalPrice
                                        .toString()) -
                                    double.parse(
                                        cartItems[index].itemPrice.toString());
                                cartItems[index]
                                    .itemOptions!
                                    .forEach((element) {
                                  cartItems[index].itemTotalPrice =
                                      double.parse(cartItems[index]
                                          .itemTotalPrice
                                          .toString()) -
                                          double.parse(
                                              element.optionPrice.toString());
                                });
                              }
                              SharedPreferences.getInstance().then((prefs) {
                                List<String> cartListItem = prefs.getStringList(
                                    SharedPreferencesKey.cart) ??
                                    [];
                                print('cartListItem: $cartListItem');
                                cartListItem[index] =
                                    jsonEncode(cartItems[index].toJson());
                                prefs.setStringList(
                                    SharedPreferencesKey.cart, cartListItem);
                                cartListItem = prefs.getStringList(
                                    SharedPreferencesKey.cart) ??
                                    [];
                                print('cartListItem1: $cartListItem');
                                cartList.value = cartFromJson(
                                    "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
                              });
                            } else {
                              cartItems.removeAt(index);
                              SharedPreferences.getInstance().then((prefs) {
                                List<String> cartListItem = prefs.getStringList(
                                    SharedPreferencesKey.cart) ??
                                    [];
                                cartListItem.removeAt(index);
                                prefs.setStringList(
                                    SharedPreferencesKey.cart, cartListItem);
                                cartList.value = cartFromJson(
                                    "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
                                controller.cartItems = cartList.value;
                                controller.calculatePrices();
                              });
                            }

                            startPositionSub = true;
                            controller.update();
                            Future.delayed(const Duration(milliseconds: 50),
                                    () {
                                  startPositionSub = false;
                                  controller.update();
                                  controller.checkPromPrices();
                                  controller.calculatePrices();
                                });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                            Icon(Icons.remove, color: AppTheme.colorAccent),
                          ),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 100),
                      alignment: startPositionAdd
                          ? Alignment.centerRight
                          : startPositionSub
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Container(
                          height: Get.width * .1,
                          width: Get.width * .1,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppTheme.colorPrimary, width: 2),
                              color: AppTheme.colorAccent,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                                cartItems[index].itemQuantity.toString(),
                                style: AppTheme.lightStyle(
                                    color: Colors.white,
                                    size: Get.width * .035)),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12)
            ],
          ),
        );
      },
    );
  }
}

