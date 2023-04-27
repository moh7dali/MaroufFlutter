import 'dart:convert';
import 'dart:io';

import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/helper.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/main_response.dart';
import '../models/signup_model.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/constant/static_variables.dart';
import '../utils/device_info.dart';
import '../utils/theme/app_theme.dart';

class AuthViewModel extends GetxController {
  DeviceInfo deviceInfo = DeviceInfo();
  String inviteTex = '';
  String myCode = '';

  @override
  void onInit() {
    deviceInfo.getDeviceInfo();
    getInviteText();
  }

  login(Function function) async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {

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

  developBy() {
    Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('developedBy'.tr,
                      style:
                          AppTheme.lightStyle(color: Colors.black, size: 24)),
                ),
              ),
              Image.asset(AssetsConstant.mozaicLogo),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://www.mozaicis.com'));
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 8, right: 8),
                          child: Text(
                            'www.mozaicis.com',
                            style: AppTheme.lightStyle(
                                color: const Color(0xff00c2c2), size: 24),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cancel'.tr),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        barrierColor:
            AppTheme.lightTheme.scaffoldBackgroundColor.withOpacity(0.6),
        barrierDismissible: true);
  }

  getInviteText() async {
    SharedPreferences.getInstance().then((value) async {
      myCode = value.getString(SharedPreferencesKey.userCode) ?? '';
      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getInviteUrl,
        body: {},
        files: {},
      ).then((response) async {
        print('sacasc' + response);
        MainResponse mainResponse =
            MainResponse.fromJson(json.decode(response));
        update();
        if (mainResponse.isSucceeded!) {
          inviteTex = json.decode(response)['Data'] ?? '';
          print(myCode);
          update();
        } else {
          if (mainResponse.errors!.isNotEmpty) {
            Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    });
  }
}
