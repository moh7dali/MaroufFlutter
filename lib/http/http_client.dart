import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/main.dart';
import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/utils/one_signal_config.dart';

import '../models/signup_model.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../utils/navigation.dart';
import '../view/screens/signin_screen.dart';

class HttpClientApp {
  Future<String> request(
      {required String method,
        required String url,
        required Map<String, dynamic> body,
        required Map<String, File> files,
        String? tempToken,
        Function? function,
        bool isJson = false,
        bool needSessionToken = false}) async {
    Map<String, String> header = {
      'UserLanguage': '${appLanguage == 'ar' ? 1 : 2}',
      'UserDevicePlatform': '${Platform.isIOS ? 1 : 2}',
      'NewMobileVersion': '11',
    };
    if (tempToken != null) {
      header.putIfAbsent('TempSessionToken', () => tempToken);
    }
    await SharedPreferences.getInstance().then((value) {
      String? sessionToken = value.getString(SharedPreferencesKey.sessionToken);
      String? accessToken1 = value.getString(SharedPreferencesKey.accessToken);
      header.putIfAbsent('Authorization', () => 'Bearer $accessToken1');
      if (sessionToken != null && needSessionToken) {
        header.putIfAbsent('SessionToken', () => sessionToken);
      }
    });
    log(json.encode(body));

    var request = http.Request(method, Uri.parse(url));
    if (body.isNotEmpty) {
      if (isJson) {
        request.body = json.encode(body);
        header.putIfAbsent('Content-Type', () => 'application/json');
      } else {
        request.bodyFields = body as Map<String, String>;
      }
    }

    request.headers.addAll(header);
    http.StreamedResponse streamResponse = await request.send();
    http.Response? response;
    if (kDebugMode) {
      response = await http.Response.fromStream(streamResponse).timeout(
        const Duration(milliseconds: 100),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
    } else {
      response = await http.Response.fromStream(streamResponse).timeout(
        const Duration(milliseconds: 100),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
    }
    print(url);
    print(header);
    log(response.body);
    log(response.statusCode.toString());
    if (streamResponse.statusCode == 200) {
    } else if (streamResponse.statusCode == 401) {
      final prefs= await SharedPreferences.getInstance();
      bool isLogin=prefs.getBool(SharedPreferencesKey.isSuccessLogin)??false;
      if(isLogin) {
        await login(() {});
        return await this
            .request(method: method, url: url, body: body, files: files);
      }else{
        return '';
      }
    } else {
      if (!response.body.startsWith("{")) {
        Get.until((_) => !Get.isDialogOpen!);
        return jsonEncode(MainResponse(isSucceeded: false, errors: [
          Error(errorCode: 0, errorMessage: 'somethingWentWrong'.tr)
        ]).toJson());
      }
    }

    return response.body;
  }

  Future login(Function function, {bool toLogin = false}) async {
    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.getDeviceInfo().then((value) {
      SharedPreferences.getInstance().then((prefs) async {
        if (prefs.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
          String? tempToken =
          prefs.getString(SharedPreferencesKey.sessionToken);
          print('-sessionToken- ${tempToken}');
          if (tempToken != null) {
            print('REQ- ${APIUrls.login}');
            var headers = {
              'UserLanguage': '${appLanguage == 'ar' ? 1 : 2}',
              'UserDevicePlatform': '2',
              'NewMobileVersion': '11',
              'SessionToken': '$tempToken',
              'Content-Type': 'application/x-www-form-urlencoded'
            };
            var request = http.Request('GET', Uri.parse(APIUrls.login));
            request.headers.addAll(headers);
            http.StreamedResponse streamResponse = await request.send();
            http.Response? response;
            if (kDebugMode) {
              response = await http.Response.fromStream(streamResponse)
              ;
            } else {
              response = await http.Response.fromStream(streamResponse);
            }
            print('RES- ${response.body}');
            SignupModel signupModel =
            SignupModel.fromJson(json.decode(response.body));
            if (signupModel.isSucceeded!) {
              SharedPreferences.getInstance().then((value) {
                value.setString(
                    SharedPreferencesKey.accessToken, signupModel.data!);
              });
              await updateNotificationToken();
              function();
            } else {
              await prefs.setBool(SharedPreferencesKey.isSuccessLogin, false);
              NavigationApp.offUntil(SigninScreen());

            }
          } else {
            if (toLogin) {
              NavigationApp.offUntil(SigninScreen());
            } else {
              prefs.remove(SharedPreferencesKey.isSuccessLogin);
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
          }
        }
      });
    });
  }

  Future updateNotificationToken() async {
    OneSignalConfig().getToken().then((token) async {
      log(token, name: 'OneSignalConfig');
      OneSignalConfig().setLanguage(appLanguage);
      await HttpClientApp().request(
        method: 'PUT',
        url: '${APIUrls.updateNotificationToken}$token',
        body: {},
        files: {},
      ).then((response) async {
        MainResponse mainResponse =
        MainResponse.fromJson(json.decode(response));
        if (mainResponse.isSucceeded!) {
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

enum RequestMethod { get, post, put, multipart }