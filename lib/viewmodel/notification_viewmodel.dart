import 'dart:convert';

import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/utils/helper.dart';
import 'package:Marouf/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/http_client.dart';
import '../models/main_response.dart';
import '../models/notification_model.dart';

class NotificationViewModel extends GetxController {
  NotificationModel notificationModel = NotificationModel();
  bool isLoading = true;

  int page = 0;
  int limit = 10;
  bool internetConnection = false;
  bool hasNextPage = true;

  bool isFirstLoadRunning = true;

  bool isLoadMoreRunning = false;

  List<NotificationItemModel> orders = [];

  firstLoad() async {
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getNotification + '?pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      notificationModel = NotificationModel.fromJson(json.decode(response));
      orders = notificationModel.notificationList ?? [];
      isFirstLoadRunning = false;
      update();
      if (notificationModel.isSucceeded!) {
      } else {
        if (notificationModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(notificationModel.errors![0].errorMessage!);
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
        url: APIUrls.getNotification + '?pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
        isFirstLoadRunning = false;
        NotificationModel notificationModel =
        NotificationModel.fromJson(json.decode(response));

        List<NotificationItemModel> notificationList =
            notificationModel.notificationList ?? [];
        if (notificationList.isNotEmpty) {
          orders.addAll(notificationList);
          update();
        } else {
          hasNextPage = false;
          update();
        }

        update();
        if (notificationModel.isSucceeded!) {
        } else {
          if (notificationModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(notificationModel.errors![0].errorMessage!);
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

    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  Future<void> refreshScreen() async {
    isFirstLoadRunning = true;
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

  Future readNotification(int id) async {
    await HttpClientApp().request(
      method: 'PUT',
      url: '${APIUrls.readNotification}$id',
      body: {},
      files: {},
    ).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        notificationModel.notificationList!
            .firstWhere((element) => element.id == id)
            .isReaded = true;
        Get.lazyPut(() => MainViewModel());
        MainViewModel mainViewModel = Get.find<MainViewModel>();
        mainViewModel.getNotificationUnRead();
        update();
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  MainResponse? mainResponse;
  Future readAllNotifications() async {
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.readAllNotifications,
      body: {},
      files: {},
    ).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        notificationModel.notificationList!.forEach((element) {
          element.isReaded = true;
        });
        update();
        Get.lazyPut(() => MainViewModel());
        MainViewModel mainViewModel = Get.find<MainViewModel>();
        mainViewModel.getNotificationUnRead();
        update();
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
