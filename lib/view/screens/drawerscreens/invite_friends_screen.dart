import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/viewmodel/invite_friends_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constant/assets_constant.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<InviteFriendsViewModel>(
            init: InviteFriendsViewModel(),
            builder: (controller) {
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(AssetsConstant.inviteBack,
                        fit: BoxFit.cover),
                  ),
                  AnimatedPositioned(
                      top: controller.isAnimated
                          ? Get.height * .1
                          : Get.height * .13,
                      left: 0,
                      right: 0,
                      child: Hero(
                          tag: 'logoTAg',
                          child: Image.asset(
                            AssetsConstant.splashLogo,
                            height: Get.height * .2,
                          )),
                      duration: const Duration(seconds: 1)),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text('inviteFriends'.tr,
                        style:
                            AppTheme.lightStyle(color: AppTheme.colorAccent, size: 20)),
                    iconTheme: const IconThemeData(color: AppTheme.colorAccent),
                  ),
                  Positioned(
                      top: Get.height * .42,
                      left: 16,
                      right: 16,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: controller.isAnimated ? 0 : 1,
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                'inviteTxt'.tr,
                                textAlign: TextAlign.center,
                                style: AppTheme.lightStyle(
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                controller.myCode,
                                textAlign: TextAlign.center,
                                style: AppTheme.lightStyle(
                                  color: AppTheme.colorPrimary,
                                  size: 19.sp,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Share.share(controller.inviteTex);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:AppTheme.colorAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 12),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      'invite'.tr,
                                      style: AppTheme.lightStyle(
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              );
            }));
  }
}
