import 'dart:convert';

import 'package:Marouf/models/rewards_gallary_model.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/viewmodel/loyalty_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/main_response.dart';
import '../utils/helper.dart';
import '../utils/navigation.dart';
import '../utils/theme/app_theme.dart';
import '../view/screens/my_rewards_screen.dart';

class RedemptionRewardsViewModel extends GetxController{

  late RewardsGallary rewardsGallary;
  bool isLoading = true;

  @override
  void onInit() {
    init();
  }

  init() {
    isLoading = true;
    update();
    getRedemptionRewards();
  }

  getRedemptionRewards() async {
    SharedPreferences.getInstance().then((value) async {
      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getRedemptionRewards,
        body: {},
        files: {},
      ).then((response) async {
        isLoading = false;
        rewardsGallary = RewardsGallary.fromJson(json.decode(response));
        update();
        if (rewardsGallary.isSucceeded!) {
        } else {
          if (rewardsGallary.errors!.isNotEmpty) {
            Helper().errorSnackBar(rewardsGallary.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    });
  }

  redeemGift(int id)async{
    Get.back();
    Helper().loading();
    await HttpClientApp().request(
        method: 'POST',
        url: '${APIUrls.rewardGift}/$id',
        body: {},
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        Get.back();
        Get.put(LoyaltyViewModel());
        LoyaltyViewModel viewModel=Get.find<LoyaltyViewModel>();
        viewModel.init();
        Get.dialog(
            AlertDialog(
              shape:
              const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(
                      Radius.circular(
                          32.0))),
              content: Column(
                mainAxisSize:
                MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                32.0))),
                    width: Get.width * .9,
                    height: Get.height * .2,
                    child: Image.asset(
                      AssetsConstant
                          .rewardsGif,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.all(
                        8.0),
                    child: Text(
                        'congratulations'.tr,
                        style: AppTheme
                            .boldStyle(
                            color: Colors
                                .black,
                            size: 14)),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .only(
                              top: 12.0,
                              left: 8,
                              right: 8),
                          child: Text(
                            'enjoyGifting'.tr,
                            textAlign:
                            TextAlign
                                .center,
                            style: AppTheme
                                .lightStyle(
                                color: Colors
                                    .black,
                                size: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actionsAlignment:
              MainAxisAlignment.start,
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          NavigationApp.off(MyRewardsScreen());
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .only(
                              bottom:
                              12.0,
                              left: 8,
                              right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(
                                    0xc1ff002a),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                            child: Center(
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(
                                    8.0),
                                child: Text(
                                  'myRewards'
                                      .tr,
                                  style: TextStyle(
                                      color: Colors
                                          .white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .only(
                              bottom:
                              12.0,
                              left: 8,
                              right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border
                                    .all(),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                            child: Center(
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(
                                    8.0),
                                child: Text(
                                    'Cancel'
                                        .tr),
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
            barrierColor: AppTheme.lightTheme
                .scaffoldBackgroundColor
                .withOpacity(0.6),
            barrierDismissible: true);


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


}