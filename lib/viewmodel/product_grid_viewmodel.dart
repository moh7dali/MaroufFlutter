import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/offers_info_model.dart';
import '../models/products_model.dart';
import '../utils/helper.dart';

class ProductGridViewModel extends GetxController {
  int page = 1;
  int limit = 10;
  bool internetConnection = false;

  bool hasNextPage = true;

  bool isFirstLoadRunning = true;

  bool isLoadMoreRunning = false;

  late ScrollController scrollController;

  List<ProductItem> products = [];

  final int categoryId;

  ProductGridViewModel(this.categoryId);

  @override
  void onInit() {
    super.onInit();
    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  firstLoad() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getProductByCategory}?categoryId=$categoryId&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      print(response);

        ProductModel productsModel = ProductModel.fromJson(json.decode(response));
        products = productsModel.productItems ?? [];
        isFirstLoadRunning = false;
        update();
        if (productsModel.isSucceeded!) {
        } else {
          if (productsModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(productsModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }


    });
  }

  void _loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      page += 1;
      await HttpClientApp().request(
        method: 'GET',
        url:  '${APIUrls.getProductByCategory}?categoryId=$categoryId&pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {

          ProductModel productsModel =
              ProductModel.fromJson(json.decode(response));
          isLoadMoreRunning = false;
          update();
          List<ProductItem> notificationList = productsModel.productItems ?? [];
          if (notificationList.isNotEmpty) {
            products.addAll(notificationList);
          } else {
            hasNextPage = false;
            update();
          }
          if (productsModel.isSucceeded!) {
          } else {
            if (productsModel.errors!.isNotEmpty) {
              Helper().errorSnackBar(productsModel.errors![0].errorMessage!);
            } else {
              Helper().errorSnackBar('defaultError'.tr);
            }
          }


      });
    }
  }

  Future<void> refreshScreen() async {
    page = 1;
    limit = 10;
    internetConnection = false;
    hasNextPage = true;
    isFirstLoadRunning = false;
    isLoadMoreRunning = false;
    products = [];
    update();
    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    isFirstLoadRunning = true;
    scrollController.removeListener(_loadMore);
    super.dispose();
  }
}
