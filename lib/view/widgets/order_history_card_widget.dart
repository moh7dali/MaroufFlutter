import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/order_details_screen.dart';
import 'package:uuid/uuid.dart';

import '../../http/api_urls.dart';
import '../../http/http_client.dart';
import '../../main.dart';
import '../../models/cart_model.dart';
import '../../models/main_response.dart';
import '../../models/order_history.dart';
import '../../models/re_order_model.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../utils/navigation.dart';
import '../../viewmodel/my_orders_viewmodel.dart';

class OrderCardWidget extends StatefulWidget {
  final UserOrderModel order;
  MyOrdersViewModel myOrdersViewModel;

  OrderCardWidget(
      {Key? key, required this.order, required this.myOrdersViewModel})
      : super(key: key);

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  bool isReOrder = false;

  reOrder() async {
    Helper().actionDialog('reOrder'.tr, 'reOrderConfirmation'.tr,
        confirmText: 'reOrder'.tr, confirm: () async {
      Get.back();
      Helper().loading();
      SharedPreferences.getInstance().then((prefs) {
        prefs.setStringList(SharedPreferencesKey.cart, []);
        cartList.value = cartFromJson(
            "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
      });
      await HttpClientApp().request(
        method: 'GET',
        url: '${APIUrls.reOrder}?id=${widget.order.id}',
        body: {},
        files: {},
      ).then((response) async {
        Get.back();
        ReOrderModel reorderModel =
            ReOrderModel.fromJson(json.decode(response));
        if (reorderModel.isSucceeded!) {
          for (int x = 0; x < reorderModel.data!.length; x++) {
            OrderItem orderItemModel = reorderModel.data![x];
            var uuid = const Uuid();
            String uniqueId = uuid.v1();

            var body = {
              "ItemId": "${orderItemModel.id!}",
              "ItemName": orderItemModel.name!,
              "ItemCategoryId": "${orderItemModel.categoryId!}",
              "ItemURL": orderItemModel.imageUrl ?? '',
              "ItemPrice": '${orderItemModel.price}',
              "ItemOfferPrice": orderItemModel.offerPrice,
              "ItemTotalOfferPrice": orderItemModel.itemTotalPrice,
              "ItemPriceId": '${orderItemModel.priceId}',
              "ItemPriceUnit": appLanguage == 'ar' ? 'د.آ' : 'JD',
              "ItemBrandId": '1',
              "ItemBrandName": 'theCakShop',
              "HasOptions": '${orderItemModel.hasOptions}',
              "ItemInstructions": '',
              "ItemQuantity": '${orderItemModel.quantity}',
              "ItemUniqueId": uniqueId,
              "ItemTotalPrice": '${orderItemModel.itemTotalPrice}',
            };
            if (orderItemModel.priceName != null) {
              body.putIfAbsent('ItemPriceName', () => orderItemModel.priceName);
            }
            var listOption = [];
            if (reorderModel.data![x].hasOptions!) {
              reorderModel.data![x].reorderOptionItems!.forEach((value) {
                var jsonOptions = {};
                jsonOptions.putIfAbsent('optionId', () => '${value.id}');
                jsonOptions.putIfAbsent(
                    'optionPrice', () => value.itemTotalPrice / value.quantity);
                jsonOptions.putIfAbsent('optionName', () => '${value.name}');
                jsonOptions.putIfAbsent(
                    'optionParentId', () => '${value.optionId}');
                listOption.add(jsonOptions);
              });
            }
            body.putIfAbsent('itemOptions', () => listOption);
            var productProperties = [];
            if (orderItemModel.productProperties != null &&
                orderItemModel.productProperties!.isNotEmpty) {
              orderItemModel.productProperties!.forEach((value) {
                var jsonOptions = {};
                jsonOptions.putIfAbsent('Id', () => '${value.id}');
                jsonOptions.putIfAbsent('Value', () => value.value);
                body['ItemURL'] = value.imageUrl;
                productProperties.add(jsonOptions);
              });
              body.putIfAbsent('ProductProperties', () => listOption);
            }
            addToCart(body);
          }
        } else {
          if (reorderModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(reorderModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    }, cancel: () {
      Get.back();
    });
  }

  addToCart(Map<String, dynamic> body) async {
    SharedPreferences.getInstance().then((value) {
      List<String> cartListItem =
          value.getStringList(SharedPreferencesKey.cart) ?? [];
      bool isExist = false;
      int index = 0;
      for (int i = 0; i < cartListItem.length; i++) {
        print(json.decode(cartListItem[i])['ItemId']);
        print(json.decode(cartListItem[i])['ItemTotalPrice']);
        print(json.decode(cartListItem[i])['ItemQuantity']);
        print('----');
        print(body['ItemId']);
        print(body['ItemTotalPrice']);
        print(body['ItemQuantity']);
        List<CartItem> list = cartFromJson(
            "${value.getStringList(SharedPreferencesKey.cart) ?? []}");
        print('asdsa ${list[i].itemOptions!.length}');
        print(
            'asdsa ${CartItem.fromJson(json.decode(json.encode(body))).itemOptions!.length}');
        print(
            'asdsa ${List<dynamic>.from(list[i].itemOptions!.map((x) => x.toJson()))}');
        print(
            'asdsa ${List<dynamic>.from(CartItem.fromJson(json.decode(json.encode(body))).itemOptions!.map((x) => x.toJson()))}');

        Function eq = const ListEquality().equals;
        if (body['ItemId'] == json.decode(cartListItem[i])['ItemId'] &&
            List<dynamic>.from(list[i].itemOptions!.map((x) => x.toJson()))
                    .toString() ==
                List<dynamic>.from(
                    CartItem.fromJson(json.decode(json.encode(body)))
                        .itemOptions!
                        .map((x) => x.toJson())).toString()) {
          if (json.decode(cartListItem[i])['ProductProperties'] != null) {
            if (json.decode(cartListItem[i])['ProductProperties'][0]['Id'] ==
                body['ProductProperties'][0]['Id']) {
              index = i;
              isExist = true;
            }
          }
        } else if (eq([
          body['ItemId'],
          body['ItemTotalPrice'],
          body['ItemQuantity']
        ], [
          json.decode(cartListItem[i])['ItemId'],
          json.decode(cartListItem[i])['ItemTotalPrice'],
          json.decode(cartListItem[i])['ItemQuantity'],
        ])) {
          if (json.decode(cartListItem[i])['ProductProperties'] != null) {
            if (json.decode(cartListItem[i])['ProductProperties'][0]['Id'] ==
                body['ProductProperties'][0]['Id']) {
              index = i;
              isExist = true;
            }
          }
        }
      }
      if (isExist) {
        print('true');
        log(jsonEncode(body));
        body['ItemTotalPrice'] = (double.parse(json
                .decode(cartListItem[index])['ItemTotalPrice']
                .toString())) +
            (double.parse(body['ItemTotalPrice'].toString()));
        body['ItemQuantity'] =
            '${(int.parse(json.decode(cartListItem[index])['ItemQuantity'].toString())) + (int.parse(body['ItemQuantity'].toString()))}';
        log(jsonEncode(body));
        cartListItem[index] = json.encode(body);
      } else {
        cartListItem.add(json.encode(body));
        print('false');
      }
      value.setStringList(SharedPreferencesKey.cart, cartListItem);
      cartList.value = cartFromJson(
          "${value.getStringList(SharedPreferencesKey.cart) ?? []}");
      setState(() {});
      log(cartToJson(cartList.value));
      Get.back();
      Helper().addToCartDialog(context, isTop: true);

      Future.delayed(Duration(seconds: 1), () {
        // Get.back();
        Helper().successfullySnackBar('productAddedSuccessfully'.tr);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${'orderId'.tr}: ${widget.order.id}',
                            style: AppTheme.lightStyle(
                                color: Colors.black, size: 16)),
                        Text(
                            '${'orderDate'.tr}: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(widget.order.creationDate!).add(const Duration(hours: 3))).replaceAll('AM', 'am'.tr).replaceAll('PM', 'pm'.tr)}',
                            style: AppTheme.lightStyle(
                                color: Colors.black, size: 16)),
                        if (widget.order.isScheduled!)
                          Text(
                              '${'deliveryDate'.tr}: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(widget.order.deliveryDate!)).replaceAll('AM', 'am'.tr).replaceAll('PM', 'pm'.tr)}',
                              style: AppTheme.lightStyle(
                                  color: Colors.black, size: 16)),
                        Text(
                            '${'orderStatus'.tr}: ${getStatus(widget.order.statusID!)[0].tr}',
                            style: AppTheme.lightStyle(
                                color: Colors.black, size: 16)),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      getStatus(widget.order.statusID!)[1],
                      width: 50,
                        color:AppTheme.colorPrimary
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getStatus(widget.order.statusID!)[2] == 'true'
                    ? [
                        if (!widget.order.isRated!)
                          GestureDetector(
                            onTap: () {
                              double rate = 1;
                              final feedbackController =
                                  TextEditingController();

                              Get.defaultDialog(
                                backgroundColor: Colors.black45,
                                title: 'rateOrder'.tr,
                                titleStyle:
                                    AppTheme.boldStyle(color: Colors.white),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'rateUs'.tr,
                                      style: AppTheme.lightStyle(
                                          color: Colors.white, size: 18),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingBar.builder(
                                        initialRating: rate,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          rate = rating;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        maxLines: 2,
                                        style: AppTheme.lightStyle(
                                            color: Colors.white),
                                        controller: feedbackController,
                                        decoration: InputDecoration(
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 2)),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2)),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2)),
                                            hintText: 'leaveFeed'.tr,
                                            hintStyle: AppTheme.lightStyle(
                                                color: Colors.white, size: 22)),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      rateOrder({
                                        "OrderId": widget.order.id,
                                        "RateValue": rate,
                                        "CustomerFeedback":
                                            feedbackController.text
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12.0, left: 8, right: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'send'.tr,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12.0, left: 8, right: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Cancel'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AssetsConstant.rateOrder,
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'rateOrder'.tr,
                                  ),
                                )
                              ],
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            fromNotification = false;
                            NavigationApp.to(OrderDetailsScreen(
                              orderId: widget.order.id!,
                            ));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AssetsConstant.viewOrder,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('viewOrder'.tr),
                              )
                            ],
                          ),
                        ),
                        if (isReOrder)
                          GestureDetector(
                            onTap: () {
                              reOrder();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AssetsConstant.reOrder,
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('reOrder'.tr),
                                )
                              ],
                            ),
                          ),
                      ]
                    : [
                        GestureDetector(
                          onTap: () {
                            fromNotification = false;

                            NavigationApp.to(OrderDetailsScreen(
                              orderId: widget.order.id!,
                            ));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AssetsConstant.viewOrder,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('viewOrder'.tr),
                              )
                            ],
                          ),
                        ),
                        if (isReOrder)
                          GestureDetector(
                            onTap: () {
                              reOrder();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AssetsConstant.reOrder,
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('reOrder'.tr),
                                )
                              ],
                            ),
                          ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
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
        isReOrder = true;
        if (mounted) setState(() {});
        return ['orderIsCanceled', AssetsConstant.orderCanceled, 'false'];
      case 6:
        isReOrder = true;
        if (mounted) setState(() {});
        return ['orderComplete', AssetsConstant.closed, 'true'];
      case 10:
        isReOrder = true;
        if (mounted) setState(() {});
        return ['failedPayment', AssetsConstant.failedPayment, 'false'];
      default:
        return ['unknown'];
    }
  }

  rateOrder(var body) async {
    Get.back();
    Helper().loading();
    await HttpClientApp().request(
        method: 'POST',
        url: APIUrls.rateOrder,
        body: body,
        isJson: true,
        files: {}).then((response) async {
      Get.back();
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        Helper().successfullySnackBar('thanksForRating'.tr);
        widget.myOrdersViewModel.firstLoad();
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }
}
