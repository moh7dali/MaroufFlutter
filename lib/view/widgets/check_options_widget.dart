import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/main_viewmodel.dart';
import '../screens/bottomnavigationscreens/branches_screen.dart';
import '../screens/bottomnavigationscreens/loyalty_screen.dart';
import '../screens/drawerscreens/connect_with_us_screen.dart';
import '../screens/my_rewards_screen.dart';
import '../screens/signin_screen.dart';


class CheckInOptionsWidget extends StatefulWidget {
  const CheckInOptionsWidget({Key? key}) : super(key: key);

  @override
  State<CheckInOptionsWidget> createState() => _CheckInOptionsWidgetState();
}

class _CheckInOptionsWidgetState extends State<CheckInOptionsWidget> {
  bool isOpenDialog = false;

  @override
  void initState() {
    isOpenDialog = true;
    if (mounted) setState(() {});
    Future.delayed(const Duration(milliseconds: 100), () {
      isOpenDialog = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.01),
      body: GetBuilder<MainViewModel>(
        init: MainViewModel(),
        builder: (mainController) {
          return GestureDetector(
            onTap: () {
              isOpenDialog = true;
              if (mounted) setState(() {});
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.back();
              });
            },
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black.withOpacity(0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: Get.height * 0.6,
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment: isOpenDialog
                              ? Alignment.bottomCenter
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                isOpenDialog = true;
                                if (mounted) setState(() {});
                                Future.delayed(const Duration(milliseconds: 300),
                                        () {
                                      Get.back();
                                      NavigationApp.to(MyRewardsScreen());
                                    });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'myRewards'.tr,
                                    style: AppTheme.lightStyle(
                                      color: Colors.white,
                                      size: Get.width * .04,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      AssetsConstant.loyaltyIcon,
                                      width: Get.width * .2,
                                      color: Colors.white,
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment: isOpenDialog
                              ? Alignment.bottomCenter
                              : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                isOpenDialog = true;
                                if (mounted) setState(() {});
                                Future.delayed(const Duration(milliseconds: 300),
                                    () {
                                  Get.back();
                                  NavigationApp.to(LoyaltyScreen());
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'myPoint'.tr,
                                    style: AppTheme.lightStyle(
                                      color: Colors.white,
                                      size: Get.width * .04,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      AssetsConstant.myPoint,
                                      width: Get.width * .2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
