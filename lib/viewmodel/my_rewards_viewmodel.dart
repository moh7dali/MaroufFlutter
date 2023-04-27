import 'dart:convert';

import 'package:Marouf/http/http_client.dart';
import 'package:Marouf/models/my_reward_model.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../utils/helper.dart';

class MyRewardsViewModel extends GetxController{
  MyRewards rewardModel = MyRewards();
  bool isLoading = true;

  @override
  void onInit() {
    init();
  }

  init() {
    rewardModel = MyRewards();
    isLoading = true;
    update();
    getNotification();
  }

  getNotification() async {

      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getMyRewards,
        body: {},
        files: {},
      ).then((response) async {
        isLoading = false;
        rewardModel = MyRewards.fromJson(json.decode(response));
        update();
        if (rewardModel.isSucceeded!) {
        } else {
          if (rewardModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(rewardModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
  }


}