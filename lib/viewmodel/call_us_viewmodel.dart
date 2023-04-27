import 'dart:convert';

import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/http/http_client.dart';
import 'package:Marouf/models/contact_info_model.dart';
import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

class CallUsViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final sakeKey = GlobalKey<ShakeWidgetState>();
  final email = TextEditingController();
  final message = TextEditingController();
  ContactInfo contactInfo = ContactInfo();
  bool isLoading=true;

  @override
  void onInit() {
    getContactInfo();
    super.onInit();
  }

  getContactInfo() {
    HttpClientApp().request(
        method: 'GET',
        url: APIUrls.contactInfo,
        body: {},
        files: {}).then((response) {
       contactInfo = ContactInfo.fromJson(json.decode(response));

      if (contactInfo.isSucceeded!) {
      } else {
        if (contactInfo.errors!.isNotEmpty) {
          Helper().errorSnackBar(contactInfo.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      isLoading = false;
      update();
    });
  }

  sendMessage() {

    Helper().loading();
    HttpClientApp().request(
        method: 'POST',
        url: APIUrls.sendContactMessage,
        body: {
          "Email": email.text,
          "Message": message.text
        },
        files: {},isJson: true).then((response) {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        email.clear();
        message.clear();
        Helper().successfullySnackBar('successFully'.tr);
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
