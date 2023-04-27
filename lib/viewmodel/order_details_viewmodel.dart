import 'dart:convert';

import 'package:Marouf/models/ordrer_details.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../utils/helper.dart';

class OrderDetailsViewModel extends GetxController{
  int orderId;
  OrderDetailsViewModel(this.orderId);
  bool isLoading = true;
  late OrderDetails orderDetails;
  double discountPromo = 0;
  int? discountAmountPercent;
  double? discountPrice = 0;
  @override
  void onInit() {
    getOrderDetails();

  }

  getOrderDetails() async {
    isLoading = true;
    update();
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.orderDetails}?id=$orderId',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      isLoading = false;
      update();
      orderDetails = OrderDetails.fromJson(json.decode(response));
      if (orderDetails.isSucceeded!) {
        double discount = orderDetails.discount ?? 0;
        if (discount > 0) {
          discountAmountPercent = (discount * 100).toInt();
          discount = orderDetails.subTotalAmount * discount;
          discountPrice = discount;
        }
        if (orderDetails.discountAmount >= orderDetails.subTotalAmount) {
          discountPromo = orderDetails.subTotalAmount;
        } else {
          discountPromo = orderDetails.discountAmount;
        }
      } else {
        if (orderDetails.errors!.isNotEmpty) {
          Helper().errorSnackBar(orderDetails.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }




}
