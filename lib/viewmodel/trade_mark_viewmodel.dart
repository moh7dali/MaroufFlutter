import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/products_model.dart';
import '../models/trade_mark_model.dart';
import '../utils/helper.dart';

class TradeMarkViewModel extends GetxController{
  final int tradeMarkId;
  final String tradeMarkName;
  bool isLoading = true;
  List<ProductItem>products=[];
  int page = 1;
  int limit = 10;
  bool internetConnection = false;

  bool hasNextPage = true;

  bool isFirstLoadRunning = false;

  bool isLoadMoreRunning = false;

  late ScrollController scrollController;

  TradeMarkViewModel(this.tradeMarkId, this.tradeMarkName);

  @override
  void onInit() {
    super.onInit();
    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  getTradeMarkProducts() async {

    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getTradeMarkProducts}?trademarkId=$tradeMarkId&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      TradeMarkModel tradeMarkModel = TradeMarkModel.fromJson(json.decode(response));
      if (tradeMarkModel.isSucceeded!) {
        products= tradeMarkModel.data?? [];
      } else {
        if (tradeMarkModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(tradeMarkModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      isLoading = false;
      update();
    });
  }

  firstLoad() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getTradeMarkProducts}?trademarkId=$tradeMarkId&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      isFirstLoadRunning = false;
      TradeMarkModel productModel = TradeMarkModel.fromJson(json.decode(response));
      products = productModel.data ?? [];
      update();
      if (productModel.isSucceeded!) {
      } else {
        if (productModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(productModel.errors![0].errorMessage!);
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
        url: '${APIUrls.getTradeMarkProducts}?trademarkId=$tradeMarkId&pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
        isFirstLoadRunning = false;
        TradeMarkModel productModel =
        TradeMarkModel.fromJson(json.decode(response));

        final List<ProductItem> fetchedPosts = productModel.data ?? [];
        if (fetchedPosts.isNotEmpty) {
          products.addAll(fetchedPosts);
          update();
        } else {
          hasNextPage = false;
          update();
        }

        update();
        if (productModel.isSucceeded!) {
        } else {
          if (productModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(productModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });

      isLoadMoreRunning = false;
      update();
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
    update();
    scrollController.removeListener(_loadMore);
    super.dispose();
  }

}