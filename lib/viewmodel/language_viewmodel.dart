import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:Marouf/utils/one_signal_config.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/main_response.dart';
import '../utils/helper.dart';

class LanguageViewModel extends GetxController{

  String ?currentLang;


  @override
  void onInit() {
    getSavedLanguage();
  }

  getSavedLanguage(){
    SharedPreferences.getInstance().then((value) {
      currentLang=value.getString(SharedPreferencesKey.appLang)??'en';
      update();
    });
  }

  changeLanguage(String lang) {
    Get.updateLocale( Locale(lang));
    appLanguage=lang;
    currentLang=lang;
    SharedPreferences.getInstance().then((value) {
      value.setString(SharedPreferencesKey.appLang,lang);
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {

        requestUpdateLanguage(lang);
        OneSignalConfig().setLanguage(lang);
      }
    });
    update();
    Get.deleteAll();
    Get.offAll(MainScreen());
  }
  requestUpdateLanguage(lang)async{
    Helper().loading();
    await HttpClientApp().request(
        method: 'PUT',
        body: {},
        url: '${APIUrls.changeLanguage}?languageId=${lang=='ar'?'1':'2'}',
        files: {}).then((response) async {
      MainResponse mainResponse= MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        update();
        Get.deleteAll();
        Get.offAll(MainScreen());
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      log(response, name: 'sendNumber');
    });
  }
}