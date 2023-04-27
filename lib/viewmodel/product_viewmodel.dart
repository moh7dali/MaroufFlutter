import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Marouf/models/cart_model.dart';
import 'package:Marouf/models/order_history.dart';
import 'package:Marouf/models/products_model.dart';
import 'package:Marouf/models/product_details.dart';
import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/viewmodel/cart_viewmodel.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../utils/navigation.dart';
import '../view/screens/signin_screen.dart';

class ProductViewModel extends GetxController {
  TextEditingController specialInstructionsController =TextEditingController();
  final int productItem;
  ProductDetails productDetails = ProductDetails();
  late ProductItemPriceModel selectedPrice;
  int? selectedColorPrice;
  DeviceInfo deviceInfo = DeviceInfo();
  bool isLoading = false;
  ProductProperties? selectedProperty;
  ProductProperties? selectedColor;
  String tagButton = 'cart';
  bool isProcessed = false;
  int quantity = 1;
  double? finalPrice;
  late double firstPrice;
  bool startPositionAdd = false;
  bool startPositionSub = false;
  Map<int, int?> radioValues = {};
  Map<int, double> radioPrices = {};
  Map<int, double> optionPrices = {};
  Map<int, List<int>> optionsValue = {};
  Map<int, String> optionsValueName = {};

  ProductViewModel(this.productItem) {
    deviceInfo.getDeviceInfo();
  }

  @override
  void onInit() {
    currentRout = '/product';
    getProductDetails(productItem);
    print("${finalPrice}++++++++++++++++++++++++++++++");
    super.onInit();
  }

  getProductDetails(int productId) async {
    isLoading = true;
    update();
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.productDetails}?productId=$productId',
      body: {},
      files: {},
    ).then((response) async {
      log(response);
      productDetails = ProductDetails.fromJson(json.decode(response));

      if (productDetails.isSucceeded!) {
        selectedPrice = productDetails.productItemPriceModel![0];
        selectedColorPrice=productDetails.productItemPriceModel![0].id;
        finalPrice=selectedPrice.price;
        update();
        if (productDetails.productItemPriceModel!.length == 1) {
          print("(((((((((((((((((((((((((((${selectedPrice.size})))))))))))))))))))))))))))");
          if (selectedPrice.offerPrice > 0) {
            finalPrice = selectedPrice.offerPrice;
            firstPrice = selectedPrice.offerPrice;
          } else {
            finalPrice = selectedPrice.price;
            firstPrice = selectedPrice.price;
          }
        }
        optionsValueName.clear();
        update();
        for (var element in productDetails.productItemOptions!) {
          optionsValueName.putIfAbsent(element.optionId!, () => element.optionLable!);
          if (element.optionType == 2) {
            radioValues.putIfAbsent(element.optionId!, () => element.optionItems!.first.productOptionItemId);
          } else {
            optionsValue.putIfAbsent(element.optionId!, () => []);
          }
        }
        isLoading = false;
        update();
      } else {
        if (productDetails.errors!.isNotEmpty) {
          Get.back();
          Helper().errorSnackBar(productDetails.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
        // isLoading = false;
        // update();
      }
    });
  }

  quantityAdd() {
    startPositionAdd = true;
    update();
    Future.delayed(const Duration(milliseconds: 50), () {
      quantity++;
      calculateFinalPrice();
      startPositionAdd = false;
      update();
    });
  }

  quantitySub() {
    startPositionSub = true;
    update();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (quantity > 1) {
        quantity--;
        calculateFinalPrice();
      }
      startPositionSub = false;
      update();
    });
  }

  calculateFinalPrice() {
    if (selectedPrice != null) {
      if (selectedPrice.offerPrice > 0) {
        finalPrice = selectedPrice.offerPrice;
        firstPrice = selectedPrice.offerPrice;
      } else {
        finalPrice = selectedPrice.price;
        firstPrice = selectedPrice.price;
      }
      radioPrices.forEach((key, value) {
        firstPrice += value;
      });
      optionPrices.forEach((key, value) {
        firstPrice += value;
      });

      finalPrice = firstPrice * quantity;
      update();
    }
  }

  login(Function function) async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        String? phone = value.getString(SharedPreferencesKey.mobileNumber);

        await HttpClientApp().login(function);
      } else {
        Helper().actionDialog(
          'notRegisterUser'.tr,
          'pleaseRegister'.tr,
          confirm: () {
            NavigationApp.offUntil(SigninScreen());
          },
          cancel: () {
            Get.back();
          },
          confirmText: 'register'.tr,
        );
      }
    });
  }

  addToCart(Map<String, dynamic> body, BuildContext context) async {
    SharedPreferences.getInstance().then((value) {
      body.putIfAbsent(
          'ItemInstructions', () => specialInstructionsController.text);
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
            'asdsa1111111 ${List<dynamic>.from(list[i].itemOptions!.map((x) => x.toJson())).toString()}');
        print(
            'asdsa222222 ${List<dynamic>.from(CartItem.fromJson(json.decode(json.encode(body))).itemOptions!.map((x) => x.toJson())).toString()}');
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
          } else {
            index = i;
            isExist = true;
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
        body['ItemTotalOfferPrice'] = (double.parse(json
            .decode(cartListItem[index])['ItemTotalOfferPrice']
            .toString())) +
            (double.parse(body['ItemTotalOfferPrice'].toString()));
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
      update();
      log(cartToJson(cartList.value));
      Get.back();
      if (Get.isRegistered<CartViewModel>()) {
        CartViewModel controller = Get.put(CartViewModel(cartList.value));
        controller.checkPromPrices();
      }
      Helper().addToCartDialog(context, isTop: true);
    });
    isProcessed = false;
    update();
  }
}
