import 'dart:convert';

import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/models/order_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/http_client.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/helper.dart';

class MyOrdersViewModel extends GetxController {
  int page = 1;
  int limit = 10;
  bool internetConnection = false;
  bool hasNextPage = true;
  bool isLogin = true;
  bool isFirstLoadRunning = true;

  bool isLoadMoreRunning = false;

  List<UserOrderModel> orders = [];

  firstLoad() async {

    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.userOrders+'?pageNumber=$page',
      body: {},
      files: {},
    ).then((response) async {
      isFirstLoadRunning = false;
      OrderHistory orderHistory = OrderHistory.fromJson(json.decode(response));
      orders = orderHistory.userOrderModel ?? [];
      update();
      if (orderHistory.isSucceeded!) {
      } else {
        if (orderHistory.errors!.isNotEmpty) {
          Helper().errorSnackBar(orderHistory.errors![0].errorMessage!);
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
        url: APIUrls.userOrders+'?pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
        isFirstLoadRunning = false;
        OrderHistory orderHistory =
            OrderHistory.fromJson(json.decode(response));
        final List<UserOrderModel> fetchedPosts =
            orderHistory.userOrderModel ?? [];
        if (fetchedPosts.isNotEmpty) {
          orders.addAll(fetchedPosts);
          update();
        } else {
          hasNextPage = false;
          update();
        }

        update();
        if (orderHistory.isSucceeded!) {
        } else {
          if (orderHistory.errors!.isNotEmpty) {
            Helper().errorSnackBar(orderHistory.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });

      isLoadMoreRunning = false;
      update();
    }
  }

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    init();

  }

  init() {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        isLogin = true;
        firstLoad();
        scrollController = ScrollController()..addListener(_loadMore);
        update();
      } else {
        isLogin = false;
        update();
      }
    });
  }

  Future<void> refreshScreen() async {
    isFirstLoadRunning = true;
    update();
    page = 1;
    limit = 10;
    internetConnection = false;
    hasNextPage = true;
    isLoadMoreRunning = false;
    orders=[];

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
