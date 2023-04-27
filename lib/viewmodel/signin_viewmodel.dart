import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/http/http_client.dart';
import 'package:Marouf/main.dart';
import 'package:Marouf/models/signup_model.dart';
import 'package:Marouf/models/user_model.dart';
import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:Marouf/utils/constant/static_variables.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/utils/one_signal_config.dart';
import 'package:Marouf/view/screens/complete_profile_screen.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:Marouf/view/screens/signin_screen.dart';
import 'package:Marouf/view/screens/verify_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/device_info.dart';
import '../utils/helper.dart';

class SigninViewModel extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
  bool isPhone = true;
  bool isAnimated = false;
  double mainOpacity = 0;
  String smsDuration = '00:00';
  Timer? timer;
  SignupModel? signupModel;
  DeviceInfo deviceInfo = DeviceInfo();
  String phoneNumber = '';

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() {
    phoneController.text = phoneNumber.replaceAll('+962', '');
    deviceInfo.getDeviceInfo();
    Future.delayed(const Duration(milliseconds: 200), () {
      mainOpacity = 1;
      update();
    });
  }

  sendCode({bool isReSend = false}) async {
    SharedPreferences.getInstance().then((value) {
      value.remove(SharedPreferencesKey.isSuccessLogin);
      value.remove(SharedPreferencesKey.accessToken);
      value.remove(SharedPreferencesKey.mobileNumber);
      value.remove(SharedPreferencesKey.sessionToken);
    });
    OneSignalConfig().getToken().then((token) {
      SharedPreferences.getInstance().then((value) async {
        smsCodeController.clear();
        update();
        Map<String, String> body = {
          "MobileNumber":
          "+962${phoneController.text.startsWith("0") ? phoneController.text.replaceFirst('0', '') : phoneController.text}",
          "DeviceId":
          '${Platform.isIOS ? deviceInfo.iosDeviceInfo!.identifierForVendor : deviceInfo.androidDeviceInfo!.id}',
          "DevicePlatform": '${Platform.isIOS ? 1 : 2}',
          "DeviceName":
          '${Platform.isIOS ? deviceInfo.iosDeviceInfo!.name : deviceInfo.androidDeviceInfo!.model}',
          "DeviceEmail": "",
          "Language": '${appLanguage == 'ar' ? 1 : 2}',
          "SystemLanguage": '${appLanguage == 'ar' ? 1 : 2}',
          "NotificationToken": token,
          "CountryId": '$countryId'
        };
        Helper().loading();
        await HttpClientApp().request(
            method: 'POST',
            url: APIUrls.verifyMobileNumber,
            body: body,
            files: {}).then((response) async {
          signupModel = SignupModel.fromJson(json.decode(response));

          Get.back();
          if (signupModel!.isSucceeded!) {
            startTimer();

            if (!isReSend) {
              NavigationApp.to(VerifyMobileScreen(
                controller: this,
              ));
            }
          } else {
            if (signupModel!.errors!.isNotEmpty) {
              Helper().errorSnackBar(signupModel!.errors![0].errorMessage!);
            } else {
              Helper().errorSnackBar('defaultError'.tr);
            }
          }
          log(signupModel!.isSucceeded.toString(), name: 'sendNumber');
        });
      });
    });
  }

  verifyCode(String code) async {
    Helper().loading();
    await HttpClientApp()
        .request(
        method: 'POST',
        url: APIUrls.checkValidationCode + code,
        body: {},
        files: {},
        tempToken: signupModel!.data!)
        .then((response) async {
      UserModel userModel = UserModel.fromJson(json.decode(response));
      if (userModel.isSucceeded!) {
        saveUser(userModel).then((value) {
          login(userModel);
        });
      } else {
        Get.back();
        if (userModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(userModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      log(userModel.isSucceeded.toString(), name: 'sendNumber');
    });
  }

  login(UserModel userModel) async {
    await HttpClientApp().login(() {
      if (userModel.isCompleted ?? false) {
        if (userModel.hasReferral ?? false) {
          //goto Main screen
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
            duration: const Duration(seconds: 1),
            transition: Transition.fadeIn);
      }
    });
  }

  Future saveUser(UserModel user) async {
    SharedPreferences.getInstance().then((value) {
      value.setString(SharedPreferencesKey.accessToken, user.accessToken!);
      value.setString(SharedPreferencesKey.sessionToken, user.sessionToken!);
      value.setBool(SharedPreferencesKey.hasReferral, user.hasReferral!);
      value.setBool(SharedPreferencesKey.isComplete, user.isCompleted!);
      value.setBool(SharedPreferencesKey.isSuccessLogin, user.isSucceeded!);
      value.setString(
          SharedPreferencesKey.mobileNumber, "+962" + phoneController.text);
    });
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      smsDuration = getDurationFormat(Duration(seconds: 60 - t.tick));
      if (t.tick == 59) {
        t.cancel();
        smsDuration = getDurationFormat(const Duration(seconds: 0));
      }
      update();
    });
  }

  resend() async {
    if (timer?.isActive ?? false) {
    } else {
      timer!.cancel();
      sendCode(isReSend: true);
    }
  }

  String getDurationFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  changeMobile() {
    // Get.delete<SigninViewModel>();
    Get.back();
    Get.back();
    timer!.cancel();
    // Get.to(SigninScreen());
  }

  @override
  void dispose() {
    timer!.cancel();
    try {
      smsCodeController.dispose();
    } catch (e) {}
    super.dispose();
  }
}
