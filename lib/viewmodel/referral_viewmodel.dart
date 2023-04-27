import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Marouf/main.dart';
import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/profile_model.dart';
import '../models/signup_model.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/constant/static_variables.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../view/screens/main_screen.dart';
import '../view/widgets/animated_shake_widget.dart';

class ReferralViewModel extends GetxController {

  final TextEditingController referralController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final referralKey = GlobalKey<ShakeWidgetState>();
  bool referralValidate = false;

  save() {
    if (referralValidate) {
      referralKey.currentState?.shake();
    } else {
      SharedPreferences.getInstance().then((value) {
        accessToken=value.getString(SharedPreferencesKey.accessToken) ?? '';
        completeProfile();
      });
    }
  }

  completeProfile() async {

    Helper().loading();
    await HttpClientApp().request(
        method: 'PUT',
        url: '${APIUrls.referralCode}?referralId=${referralController.text}',
        body: {},
        files: {}).then((response) async {
      MainResponse mainResponse= MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {

            //goto Main screen
            Get.offAll( MainScreen(),duration: const Duration(seconds: 1),transition: Transition.fadeIn);

      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage??'');
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      log(response, name: 'sendNumber');
    });
  }


}