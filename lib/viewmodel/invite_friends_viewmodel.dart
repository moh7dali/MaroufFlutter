import 'dart:convert';

import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../utils/helper.dart';

class InviteFriendsViewModel extends GetxController {
  bool isAnimated = false;
  String inviteTex = '';
  String myCode = '';

  @override
  void onInit() {
    isAnimated = true;
    update();
    getInviteText();
    super.onInit();
  }

  getInviteText() async {
    SharedPreferences.getInstance().then((value) async {
      myCode=value.getString(SharedPreferencesKey.userCode) ?? '';
      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getInviteUrl,
        body: {},
        files: {},
      ).then((response) async {
        print('sacasc' + response);
        MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
        update();
        if (mainResponse.isSucceeded!) {
          inviteTex = json.decode(response)['Data'] ?? '';
          print(myCode);
          inviteTex ='$inviteTex\n\n${'codeTxt'.tr}($myCode)';
          Future.delayed(const Duration(seconds: 1), () {
            isAnimated = false;
            update();
          });
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
