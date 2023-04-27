import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/utils/constant/notification_trigger.dart';
import 'package:Marouf/utils/theme/app_theme.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/main_response.dart';
import '../view/screens/my_rewards_screen.dart';
import '../view/screens/notification_screen.dart';
import '../view/screens/order_details_screen.dart';
import '../viewmodel/main_viewmodel.dart';
import 'constant/shared_preferences_constant.dart';
import 'helper.dart';
import 'navigation.dart';

class OneSignalConfig {
  static const String appId = 'b775f61e-5e82-42f5-b1b7-10f82db0b5a7';

  OneSignalConfig() {
    getOneSignalConfig();
  }

  Future<String> getToken() async {
    await getOneSignalConfig();
    final prefs = await SharedPreferences.getInstance();
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    prefs.setString(SharedPreferencesKey.notificationToken, osUserID!);
    print('token: $osUserID');
    return osUserID;
  }

  setLanguage(String lang) {
    print('lang: $lang');
    OneSignal.shared.setLanguage(lang);
  }

  Future getOneSignalConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await Permission.notification.request();
    if(Platform.isIOS){
      OneSignal.shared.promptUserForPushNotificationPermission();
    }
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    String? osUserID = '';
    OneSignal.shared.setAppId(appId);
    await OneSignal.shared.getDeviceState().then((value) {
      print('dfg: ${value?.userId}');
      osUserID = value?.userId;
      prefs.setString(SharedPreferencesKey.notificationToken, osUserID ?? '');
      print('token: $osUserID');
      // OneSignal.shared.setLanguage(appLanguage);
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      print(
          'notificationWillShowInForegroundHandler: ${event.notification.title}');
      event.complete(event.notification);
      handleNotificationClick(event.notification.additionalData!,
          event.notification.title!, event.notification.body!);
      MainViewModel m = Get.put(MainViewModel());
      m.getNotificationUnRead();
      await m.init();
      m.update();
      getOneSignalConfig();
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult event) {
      print("OneSignalOpened: ${event.notification.additionalData}");
      print('Get.currentR//// ${Get.currentRoute}');
      Map<String, dynamic> args = {
        'body': event.notification.body,
        'data': event.notification.additionalData,
      };
      fromNotification = true;
      Future.delayed(const Duration(milliseconds: 400), () {
        MainViewModel m = Get.put(MainViewModel());
        m.handleNotificationClick(args['data'], args['body']);
        getOneSignalConfig();
      });
    });
  }

  showNotificationDialog(String title, String body, Widget route,
      {bool isPoints = false}) {
    print('Get.currentRoute! ${Get.currentRoute}');

    if (Get.currentRoute != '/ReferralScreen') {
      Helper().actionDialog(
        title,
        body,
        confirmText: 'open'.tr,
        confirm: () {
          Get.back();
          MainViewModel m = Get.put(MainViewModel());
          m.getNotificationUnRead();
          m.update();
          Future.delayed(const Duration(milliseconds: 400), () {
            NavigationApp.to(route);
          });
        },
        cancel: () {
          Get.back();
          MainViewModel m = Get.put(MainViewModel());
          m.getNotificationUnRead();
          m.update();
        },
      );
    }
  }

  handleNotificationClick(
      Map<String, dynamic> notification, String title, String body) async {
    if(Get.isOverlaysOpen){
      print('isOverlaysOpen: ${Get.isOverlaysOpen}');
      Get.back(closeOverlays: true);
    }
    switch (int.parse(notification['trg'].toString())) {
      case NotificationTriggerType.addedPoints:
      case NotificationTriggerType.redeemedPoints:
        double rate = 1;
        final feedbackController = TextEditingController();
        Get.defaultDialog(
          backgroundColor: AppTheme.colorAccent,
          title: 'thanksForVisitCakeShop'.tr,
          titleStyle: AppTheme.boldStyle(color: Colors.white),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                body,
                style: AppTheme.lightStyle(color: Colors.white, size: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'rateBranch'.tr,
                style: AppTheme.lightStyle(color: Colors.white, size: 18),
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
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  style: AppTheme.lightStyle(color: Colors.white),
                  controller: feedbackController,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      hintText: 'leaveFeed'.tr,
                      hintStyle:
                          AppTheme.lightStyle(color: Colors.white, size: 22)),
                ),
              )
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                rateOrderOrVisit({
                  "BranchId": notification['bri'],
                  "RateValue": rate,
                  "FeedBack": feedbackController.text
                }, APIUrls.rateVisit);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'send'.tr,
                        style: const TextStyle(color: Colors.black),
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
                padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel'.tr,
                        style: AppTheme.lightStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case NotificationTriggerType.newGift:
      case NotificationTriggerType.newOffer:
      case NotificationTriggerType.giftRedeemed:
      case NotificationTriggerType.offerRedeemed:
        //goto reward details screen
        showNotificationDialog(title, body, const MyRewardsScreen(),
            isPoints: true);
        if (kDebugMode) {
          print('handleNotificationClick: goto reward details screen');
        }
        break;
      case NotificationTriggerType.systemNotification:
        //goto system notification screen
        showNotificationDialog(title, body, const NotificationScreen());
        if (kDebugMode) {
          print('handleNotificationClick: goto system notification screen');
        }
        break;
      case NotificationTriggerType.orderClosed:
        double rate = 1;
        final feedbackController = TextEditingController();

        Get.defaultDialog(
          backgroundColor: Colors.black45,
          title: 'rateOrder'.tr,
          titleStyle: AppTheme.boldStyle(color: Colors.white),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                'rateUs'.tr,
                style: AppTheme.lightStyle(color: Colors.white, size: 18),
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
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  style: AppTheme.lightStyle(color: Colors.white),
                  controller: feedbackController,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      hintText: 'leaveFeed'.tr,
                      hintStyle:
                          AppTheme.lightStyle(color: Colors.white, size: 22)),
                ),
              )
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                rateOrderOrVisit({
                  "OrderId": notification['tid'],
                  "RateValue": rate,
                  "CustomerFeedback": feedbackController.text
                }, APIUrls.rateOrder);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'send'.tr,
                        style: const TextStyle(color: Colors.black),
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
                padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel'.tr,
                        style: AppTheme.lightStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case NotificationTriggerType.orderRecieved:
      case NotificationTriggerType.newOrder:
      case NotificationTriggerType.inDeliveryOrder:
      case NotificationTriggerType.inProgressOrder:
      case NotificationTriggerType.rejectOrder:
      case NotificationTriggerType.readyForPickup:
      case NotificationTriggerType.readyForDelivery:
      case NotificationTriggerType.driverArrived:
      case NotificationTriggerType.updateOrderStatus:
        //goto order details screen
        if (kDebugMode) {
          print('handleNotificationClick: goto order details screen');
        }
        showNotificationDialog(
            title,
            body,
            OrderDetailsScreen(
              orderId: notification['tid'],
            ));
        break;
      case NotificationTriggerType.brand:
        //goto brand details screen
        showNotificationDialog(title, body, const NotificationScreen());
        if (kDebugMode) {
          print('handleNotificationClick: goto brand details screen');
        }
        break;
      case NotificationTriggerType.category:
        //goto category details screen
        showNotificationDialog(title, body, const NotificationScreen());
        if (kDebugMode) {
          print('handleNotificationClick: goto category details screen');
        }
        break;
      case NotificationTriggerType.product:
        //goto product details screen
        showNotificationDialog(title, body, const NotificationScreen());
        if (kDebugMode) {
          print('handleNotificationClick: goto product details screen');
        }

        break;
      case NotificationTriggerType.rateOrder:
        //rate order dialog (orderId)
        showNotificationDialog(title, body, const NotificationScreen());
        if (kDebugMode) {
          print('handleNotificationClick: rate order dialog (orderId)');
        }
        break;
    }
  }
}

rateOrderOrVisit(var body, String url) async {
  Get.back();
  Helper().loading();
  await HttpClientApp().request(
      method: 'POST',
      url: url,
      body: body,
      isJson: true,
      files: {}).then((response) async {
    Get.back();
    MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
    if (mainResponse.isSucceeded!) {
      Helper().successfullySnackBar('thanksForRating'.tr);
    } else {
      if (mainResponse.errors!.isNotEmpty) {
        Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
      } else {
        Helper().errorSnackBar('defaultError'.tr);
      }
    }
  });
}
