import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/models/profile_model.dart';
import 'package:Marouf/utils/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/main_response.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/helper.dart';
import '../view/screens/signin_screen.dart';

class ProfileViewModel extends GetxController {
  bool isLoading = true;
  late ProfileData profileData;
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  String versionTextView = '';
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  DeviceInfo deviceInfo = DeviceInfo();

  @override
  void onInit() {
    getProfile();
    String versionUrl = "";
    if (APIUrls.baseUrl.contains("staging")) {
      versionUrl = "staging";
    } else if (APIUrls.baseUrl.contains("development")) {
      versionUrl = "development";
    }
    String mode = "";
    if (kDebugMode) {
      mode = "DEBUG";
    }
    deviceInfo.getDeviceInfo().then((value) {
      versionTextView =
          "copyright ©  Mozaic Innovative Solutions ${DateTime.now().year} \n" +
              "Version " +
              deviceInfo.packageAppInfo!.version +
              " " +
              versionUrl +
              " " +
              mode;
    });
    update();
  }

  String getFormattedDate(String? fullDate) {
    if (fullDate == null) return '';
    DateTime date = formattedDate.parse(fullDate);
    return '${date.year}-${date.month}-${date.day}';
  }

  deleteAccount() async {
    await HttpClientApp().request(
        method: 'POST',
        url: APIUrls.deleteAccount,
        body: {},
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        SharedPreferences.getInstance().then((value) {
          value.remove(SharedPreferencesKey.isSuccessLogin);
          value.remove(SharedPreferencesKey.accessToken);
          value.remove(SharedPreferencesKey.mobileNumber);
          value.remove(SharedPreferencesKey.sessionToken);
          Get.offAll(SigninScreen());
        });
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
    update();
  }

  Future getProfile() async {
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.profileData,
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      profileData = ProfileData.fromJson(json.decode(response));
      update();
      if (profileData.isSucceeded!) {
      } else {
        if (profileData.errors!.isNotEmpty) {
          Helper().errorSnackBar(profileData.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      isLoading = false;
      update();
    });
  }
}
