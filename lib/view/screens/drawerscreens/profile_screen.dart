import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/complete_profile_screen.dart';
import 'package:Marouf/view/screens/my_addresses_screen.dart';
import 'package:Marouf/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../utils/constant/shared_preferences_constant.dart';
import '../../../utils/helper.dart';
import '../../../utils/theme/app_theme.dart';
import '../signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(AssetsConstant.completeProfileBack,
                      fit: BoxFit.cover),
                ),
                AppBar(
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text('profile'.tr,
                      style: AppTheme.boldStyle(
                          color: Colors.white, size: 20)),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        NavigationApp.to(CompleteProfileScreen(
                          isEdit: true,
                          productsModel: controller.profileData,
                        ));
                      },
                      child: Image.asset(AssetsConstant.edit,
                          color: Colors.white),
                    )
                  ],
                ),
                controller.isLoading
                    ? Container()
                    : Positioned(
                        top: Get.height * .15,
                        left: 20,
                        right: 20,
                        bottom: 40,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(1000)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                              ),
                                              child: Image.asset(
                                                AssetsConstant.fullName,
                                                color: Colors.white,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  '${controller.profileData.firstName ?? ""} ${controller.profileData.lastName ?? ""}',
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.lightStyle(
                                                      color:
                                                          Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(1000)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                ),
                                                child: Icon(
                                                  Icons.call,
                                                  color: Colors.white,
                                                )),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  controller.profileData
                                                          .mobileNumber ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: AppTheme.lightStyle(
                                                      color:
                                                          Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(1000)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                              ),
                                              child: Image.asset(
                                                AssetsConstant.date,
                                                color: Colors.white,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  controller.profileData
                                                              .birthDate ==
                                                          null
                                                      ? 'birthdate'.tr
                                                      : controller
                                                          .getFormattedDate(
                                                              controller
                                                                  .profileData
                                                                  .birthDate),
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.lightStyle(
                                                      color:
                                                          Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(1000)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                              ),
                                              child: Image.asset(
                                                AssetsConstant.gender,
                                                color: Colors.white,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  controller.profileData
                                                              .genderType ==
                                                          0
                                                      ? 'gender'.tr
                                                      : controller.profileData
                                                                  .genderType ==
                                                              1
                                                          ? 'male'.tr
                                                          : 'female'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.lightStyle(
                                                      color:
                                                          Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    // const SizedBox(height: 20),
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //         border: Border.all(
                                    //             color: Colors.white,
                                    //             width: 2),
                                    //         borderRadius:
                                    //         BorderRadius.circular(1000)),
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //       children: [
                                    //         const SizedBox(
                                    //           width: 20,
                                    //         ),
                                    //         Padding(
                                    //           padding:
                                    //           const EdgeInsets.symmetric(
                                    //             vertical: 8.0,
                                    //           ),
                                    //           child: Image.asset(
                                    //             AssetsConstant.materialState,
                                    //             color: Colors.white,
                                    //             width: 30,
                                    //             height: 30,
                                    //           ),
                                    //         ),
                                    //         Expanded(
                                    //           child: Padding(
                                    //             padding:
                                    //             const EdgeInsets.all(12.0),
                                    //             child: Text(
                                    //               controller.profileData
                                    //                   .meritalStatusType ==
                                    //                   0
                                    //                   ? 'status_st'.tr
                                    //                   : controller.profileData
                                    //                   .meritalStatusType ==
                                    //                   1
                                    //                   ? 'single'.tr
                                    //                   : 'married'.tr,
                                    //               textAlign: TextAlign.center,
                                    //               style: AppTheme.lightStyle(
                                    //                   color:
                                    //                   Colors.white,
                                    //                   size: 20),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     )),
                                    const SizedBox(height: 20),
                                    ListTile(
                                      onTap: () {
                                        NavigationApp.to(
                                            const MyAddressesScreen());
                                      },
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 40),
                                      trailing: Image.asset(
                                        AssetsConstant.edit,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        'myAddresses'.tr,
                                        style: AppTheme.lightStyle(
                                            color: Colors.white,
                                            size: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          height: 3,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                    if (Platform.isIOS)
                                      GestureDetector(
                                        onTap: () {
                                          Helper().actionDialog(
                                              'deActivateAccount'.tr,
                                              'areYouSureToDeleteAccount'.tr,
                                              confirm: () {
                                            controller.deleteAccount();
                                          }, cancel: () {
                                            Get.back();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'deActivateAccount'.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTheme.lightStyle(
                                                    color: Colors.white,
                                                    size: 18)
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (kDebugMode)
                                      GestureDetector(
                                        onTap: () {
                                          SharedPreferences.getInstance()
                                              .then((value) {
                                            value.remove(SharedPreferencesKey
                                                .isSuccessLogin);
                                            value.remove(SharedPreferencesKey
                                                .accessToken);
                                            value.remove(SharedPreferencesKey
                                                .mobileNumber);
                                            Get.offAll(SigninScreen());
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'logout'.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTheme.lightStyle(
                                                    color: Colors.white,
                                                    size: 18)
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white.withOpacity(.5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                child: Text(
                                  controller.versionTextView,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.lightStyle(
                                      color: AppTheme.colorWhite, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
