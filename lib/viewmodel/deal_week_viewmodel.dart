import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:Marouf/models/products_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/cart_model.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/helper.dart';

class DealWeekViewModel extends GetxController{

  final ProductItem productItem;
  dynamic productCount=0;

  DealWeekViewModel(this.productItem){

    cartList.value.forEach((element){
      if(element.itemId==productItem.id.toString()){
        productCount=element.itemQuantity;
        update();
        print('ldhjgcjhdbce $productCount');
      }
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
          print('sadsadsadasdasd');
          index = i;
          isExist = true;
        } else if (eq([
          body['ItemId'],
          // body['ItemTotalPrice'],
          body['ItemQuantity']
        ], [
          json.decode(cartListItem[i])['ItemId'],
          // json.decode(cartListItem[i])['ItemTotalPrice'],
          json.decode(cartListItem[i])['ItemQuantity'],
        ])) {
          index = i;
          isExist = true;
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
      cartList.value.forEach((element){
        if(element.itemId==productItem.id.toString()){
          productCount=element.itemQuantity;
        }
      });
      update();
      print( cartFromJson(
          "${value.getStringList(SharedPreferencesKey.cart) ?? []}"));
      Helper().successfullySnackBar('productAddedSuccessfully'.tr);
    });
  }
}