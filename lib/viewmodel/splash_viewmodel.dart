import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Marouf/http/http_client.dart';
import 'package:Marouf/models/adverising_model.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/adverising_screen.dart';
import 'package:Marouf/view/screens/complete_profile_screen.dart';
import 'package:Marouf/view/screens/referral_screen.dart';
import 'package:Marouf/view/screens/signin_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/view/screens/splash_screen.dart';
import 'package:Marouf/view/screens/storyboard_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../http/api_urls.dart';
import '../main.dart';
import '../models/app_version.dart';
import '../models/cart_model.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/device_info.dart';
import '../view/screens/main_screen.dart';

class SplashViewModel extends GetxController  {
  bool isAnimated = false;
  DeviceInfo deviceInfo = DeviceInfo();

  @override
  void onInit() {

    isAnimated = true;
    update();

    Future.delayed(const Duration(seconds: 1), () {
      isAnimated = false;
      update();
      getApplicationVersion();
    });

    super.onInit();
  }

  getAdvertising() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getAdvertising}?typeId=1',
      body: {},
      files: {},
    ).then((response) async {
      AdvertisingModel advertise =
          AdvertisingModel.fromJson(json.decode(response));
      if (advertise.data != null) {
        SharedPreferences.getInstance().then((value) {
          if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
            checkLogin(true, advertise);
          } else {
            checkLogin(false, null);
          }
        });
      } else {
        checkLogin(false, null);
      }
      update();
    });
  }

  checkLogin(bool isAdvertise, [AdvertisingModel? advertise]) {
    if (fromNotification == false) {
      if (isAdvertise) {
        Get.offAll(AdvertisingScreen(advertisingModel: advertise!),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 1));
      } else {
        SharedPreferences.getInstance().then((value) {
          Future.delayed(const Duration(seconds: 1), () {
            if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
              cartList.value = cartFromJson(
                  "${value.getStringList(SharedPreferencesKey.cart) ?? []}");
              if (value.getBool(SharedPreferencesKey.isComplete) ?? false) {
                if (value.getBool(SharedPreferencesKey.hasReferral) ?? false) {
                  Get.offAll(MainScreen(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                } else {
                  // goto Referral screen
                  Get.offAll(MainScreen(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.fadeIn);
                }
              } else {
                //goto Complete profile
                Get.offAll(CompleteProfileScreen(),
                    transition: Transition.fadeIn,
                    duration: const Duration(seconds: 1));
              }
            } else {
              NavigationApp.off(SigninScreen(), milliseconds: 1500);
            }
          });
        });
      }
    }
  }

  getApplicationVersion() async {
    await deviceInfo.getDeviceInfo();
    await HttpClientApp().request(
      method: 'GET',
      url:
          '${APIUrls.getApplicationVersion}?applicationId=1&currentVersionNumber=${deviceInfo.packageAppInfo!.buildNumber}',
      body: {},
      files: {},
    ).then((response) async {
      AppVersion appVersion = AppVersion.fromJson(json.decode(response));
      if (appVersion.isSucceeded!) {
        if (appVersion.forceUpdate!) {
          Get.defaultDialog(
              barrierDismissible: false,
              onWillPop: () async {
                return false;
              },
              title: 'forceUpdate'.tr,
              content: Text('forceUpdateAppMessage'.tr),
              actions: [
                InkWell(
                  onTap: () async {
                    if (Platform.isAndroid) {
                      launchUrl(Uri.parse(
                          'market://details?id=com.mozaic.www.maroufcoffee'));
                    } else if (Platform.isIOS) {
                      launchUrl(
                        Uri.parse('https://apps.apple.com/us/app/id1516582768'),
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'forceUpdateAppButton'.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
        } else {
          if (appVersion.canRecieveOrder == false) {
            stoppingOrderMessage = appVersion.reasonForStoppingOrder!;
            canOrder = false;

            Get.defaultDialog(
                barrierDismissible: false,
                onWillPop: () async {
                  return false;
                },
                title: 'appName'.tr,
                content: Text('${appVersion.reasonForStoppingOrder}'.tr),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      // Get.back();
                      getAdvertising();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'justBrowse'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
          } else {
            getAdvertising();
          }
        }
      }
      update();
    });
  }


}
