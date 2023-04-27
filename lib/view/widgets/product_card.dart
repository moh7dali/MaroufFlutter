import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/models/products_model.dart';
import 'package:Marouf/view/screens/product_screen.dart';
import 'package:Marouf/viewmodel/deal_week_viewmodel.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../models/cart_model.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/theme/app_theme.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget(this.productItem, {Key? key}) : super(key: key);
  final ProductItem productItem;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    cartList.value.forEach((element) {
      if (element.itemId == widget.productItem.id.toString()) {
        setState(() {
          productCount = int.parse(element.itemQuantity);
          print('productCount: ${productCount}');
        });
      }
    });
    return GetBuilder<DealWeekViewModel>(
      init: DealWeekViewModel(widget.productItem),
      tag: 'DealTag_${widget.productItem.id}',
      builder: (controller) {
        return Container(
          width: Get.width * .5,
          child: Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.to(
                      //   ProductScreen(productItem.id!),
                      //   transition: Transition.fadeIn,
                      // );
                      Get.bottomSheet(
                          FractionallySizedBox(
                            heightFactor: .956,
                            child: ProductScreen(widget.productItem.id!),
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          barrierColor: AppTheme.colorGrey);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: controller.productItem.imageUrl ?? '',
                              // fit: BoxFit.contain,
                              // width: Get.width * .5,
                              placeholder: (w, e) => Image.asset(
                                AssetsConstant.loading,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (c, e, s) =>
                                  Image.asset(AssetsConstant.longPlaceHolder,fit: BoxFit.contain),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('${controller.productItem.name}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.boldStyle(
                                      color: AppTheme.colorPrimary,
                                      size: 13.sp))),
                        ),
                        Text(
                          '${controller.productItem.productItemPrices![0].price} ${controller.productItem.productItemPrices![0].currancyDisplayName}',
                          textAlign: TextAlign.center,
                          style: AppTheme.boldStyle(
                              color: Color(0xff570101), size: 12.sp)
                              .copyWith(
                              decoration: widget
                                  .productItem
                                  .productItemPrices![0]
                                  .offerPrice >
                                  0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        if (controller.productItem.productItemPrices![0]
                            .offerPrice >
                            0)
                          Text(
                            '${controller.productItem.productItemPrices![0].offerPrice} ${controller.productItem.productItemPrices![0].currancyDisplayName}',
                            textAlign: TextAlign.center,
                            style: AppTheme.boldStyle(
                                color: Colors.red, size: 12.sp),
                          ),
                      ],
                    ),
                  ),
                ),
                // controller.productItem.hasOptions! ||
                //     !controller.productItem.hasOnlineOrdering!
                //     ? Container()
                //     : ValueListenableBuilder<List<CartItem>>(
                //     valueListenable: cartList,
                //     builder: (BuildContext context,
                //         List<CartItem> cartItems, Widget? child) {
                //       return Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Divider(color: AppTheme.colorPrimary),
                //           Row(
                //             children: [
                //
                //               GestureDetector(
                //                 onTap: () {
                //                   var uuid = Uuid();
                //                   String uniqueId = uuid.v1();
                //
                //                   var body = {
                //                     "ItemId": "${controller.productItem.id!}",
                //                     "ItemName": controller.productItem.name!,
                //                     "ItemCategoryId":
                //                     "${controller.productItem.categoryId!}",
                //                     "ItemURL":
                //                     controller.productItem.imageUrl ?? '',
                //                     "ItemPrice":
                //                     '${controller.productItem.productItemPrices!.first.price}',
                //                     "ItemOfferPrice": controller
                //                         .productItem
                //                         .productItemPrices!
                //                         .first
                //                         .offerPrice >
                //                         0
                //                         ? controller.productItem
                //                         .productItemPrices!.first.offerPrice
                //                         : 0.0,
                //                     "ItemTotalOfferPrice": controller
                //                         .productItem
                //                         .productItemPrices!
                //                         .first
                //                         .offerPrice >
                //                         0
                //                         ? controller.productItem
                //                         .productItemPrices!.first.offerPrice
                //                         : 0.0,
                //                     "ItemPriceId":
                //                     '${controller.productItem.productItemPrices!.first.id!}',
                //                     "ItemPriceUnit": controller
                //                         .productItem
                //                         .productItemPrices!
                //                         .first
                //                         .currancyDisplayName!,
                //                     "ItemBrandId": '1',
                //                     "ItemBrandName": 'tamam',
                //                     "HasOptions":
                //                     '${controller.productItem.hasOptions!}',
                //                     "ItemInstructions": '',
                //                     "ItemQuantity": '${1}',
                //                     "ItemUniqueId": uniqueId,
                //                     "ItemTotalPrice":
                //                     '${controller.productItem.productItemPrices!.first.price.toStringAsFixed(2)}',
                //                   };
                //                   if (controller.productItem.productItemPrices!
                //                       .length >
                //                       1) {
                //                     for (var element in controller
                //                         .productItem.productItemPrices!) {
                //                       if (element.id ==
                //                           controller.productItem
                //                               .productItemPrices!.first.id) {
                //                         body.putIfAbsent('ItemPriceName',
                //                                 () => element.size);
                //                       }
                //                     }
                //                   }
                //                   var listOption = [];
                //                   body.putIfAbsent(
                //                       'itemOptions', () => listOption);
                //                   controller.addToCart(body);
                //                   print(jsonEncode(body));
                //                   setState(() {
                //                     productCount++;
                //                   });
                //                 },
                //                 child: Padding(
                //                   padding:appLanguage=='en'? EdgeInsets.only(right:8.0):EdgeInsets.only(left:8.0),
                //                   child: Image.asset(
                //                     AssetsConstant.addIcon,
                //                     height: Get.width * .1,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           // Container(
                //           //   margin: const EdgeInsets.all(4),
                //           //   padding: const EdgeInsets.all(4),
                //           //   height: Get.width * .09,
                //           //   width: Get.width * .09,
                //           //   decoration: const BoxDecoration(
                //           //       shape: BoxShape.circle,
                //           //       color: AppTheme.colorPrimary),
                //           //   child: Center(
                //           //     child: FittedBox(
                //           //       child:
                //           //       ValueListenableBuilder<List<CartItem>>(
                //           //           valueListenable: cartList,
                //           //           builder: (context, value, child) {
                //           //             int quant = 0;
                //           //             if (value.any((element) =>
                //           //             element.itemId.toString() ==
                //           //                 widget.productItem.id
                //           //                     .toString())) {
                //           //               print(
                //           //                   'qqqqq: ${value.firstWhere((element) => element.itemId.toString() == widget.productItem.id.toString()).itemQuantity}');
                //           //               quant = int.parse(value
                //           //                   .firstWhere((element) =>
                //           //               element.itemId
                //           //                   .toString() ==
                //           //                   widget.productItem.id
                //           //                       .toString())
                //           //                   .itemQuantity
                //           //                   .toString());
                //           //             }
                //           //             return Text('${quant}',
                //           //                 style: AppTheme.boldStyle(
                //           //                     color: Colors.white,
                //           //                     size: 20));
                //           //           }),
                //           //     ),
                //           //   ),
                //           // ),
                //           // GestureDetector(
                //           //   onTap: () {
                //           //     if (cartItems.isNotEmpty) {
                //           //       for (int i = 0; i < cartItems.length; i++) {
                //           //         if (cartItems[i].itemId ==
                //           //             controller.productItem.id
                //           //                 .toString()) {
                //           //           if (int.parse(cartItems[i]
                //           //               .itemQuantity
                //           //               .toString()) ==
                //           //               1) {
                //           //             cartItems.removeAt(i);
                //           //             controller.productCount = 0;
                //           //             controller.update();
                //           //           } else if (int.parse(cartItems[i]
                //           //               .itemQuantity
                //           //               .toString()) >
                //           //               1) {
                //           //             print(cartItems[i].itemQuantity);
                //           //             print(cartItems[i].itemTotalPrice);
                //           //             cartItems[i].itemQuantity =
                //           //             '${int.parse(cartItems[i].itemQuantity.toString()) - 1}';
                //           //             cartItems[i].itemTotalPrice =
                //           //                 int.parse(cartItems[i]
                //           //                     .itemQuantity
                //           //                     .toString()) *
                //           //                     double.parse(controller
                //           //                         .productItem
                //           //                         .productItemPrices!
                //           //                         .first
                //           //                         .price
                //           //                         .toString());
                //           //             print(cartItems[i].itemQuantity);
                //           //             print(cartItems[i].itemTotalPrice);
                //           //             controller.productCount =
                //           //                 cartItems[i].itemQuantity;
                //           //
                //           //             controller.update();
                //           //           }
                //           //         }
                //           //       }
                //           //
                //           //       SharedPreferences.getInstance()
                //           //           .then((value) {
                //           //         List<String> cartIemList = [];
                //           //         for (var element in cartItems) {
                //           //           cartIemList
                //           //               .add(jsonEncode(element.toJson()));
                //           //         }
                //           //         value.setStringList(
                //           //             SharedPreferencesKey.cart,
                //           //             cartIemList);
                //           //         cartList.value = cartFromJson(
                //           //             "${value.getStringList(SharedPreferencesKey.cart) ?? []}");
                //           //       });
                //           //     }
                //           //
                //           //     if (productCount >= 1) {
                //           //       setState(() {
                //           //         productCount--;
                //           //       });
                //           //     }
                //           //   },
                //           //   child: Image.asset(
                //           //     AssetsConstant.subIcon,
                //           //     height: Get.width * .1,
                //           //   ),
                //           // ),
                //         ],
                //       );
                //     }),
                // const SizedBox(
                //   height: 8,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
