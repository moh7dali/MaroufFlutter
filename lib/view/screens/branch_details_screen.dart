import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:Marouf/models/branche_model.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/branch_details_loading_widget.dart';
import 'package:Marouf/viewmodel/branch_details_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchDetailsScreen extends StatelessWidget {
  final int branch;
  const BranchDetailsScreen({Key? key, required this.branch}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<BranchDetailsViewModel>(
        init: BranchDetailsViewModel(branch),
        builder: (controller) {
          return
            Scaffold(
            appBar: AppBar(
              title: Text(controller.isLoading?'':controller.branchDetail.name??""),
              titleTextStyle: AppTheme.lightStyle(color: AppTheme.colorAccent, size: 18),
            ),
            body: controller.isLoading
                ? BranchDetailsLoading()
                : Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: Get.height*.3,
                              fit:BoxFit.cover,
                              imageUrl: controller.branchDetail.branchImageModel
                                      ?.first.imageUrl ??
                                  '',
                              placeholder: (w, e) => Image.asset(
                                AssetsConstant.loading,
                                fit: BoxFit.fitWidth,
                                width: Get.width,
                              ),
                              errorWidget: (c, e, s) => Image.asset(
                                AssetsConstant.placeHolder,
                                fit: BoxFit.fitWidth,
                                width: Get.width,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('${controller.branchDetail.name} ',
                                      style: AppTheme.lightStyle(
                                          color: AppTheme.colorAccent,
                                          size: Get.width * 0.06)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text('${controller.branchDetail.description} ',
                                        style: AppTheme.lightStyle(
                                            color: AppTheme.colorAccent,
                                            size: Get.width * 0.04)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                      '${'address'.tr}: ${controller.branchDetail.address} ',
                                      style: AppTheme.lightStyle(
                                          color: Colors.black, size: Get.width * 0.04)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('${'workingHour'.tr}: ',
                                      style: AppTheme.lightStyle(
                                          color: Colors.black, size: Get.width * 0.04)),
                                  Expanded(
                                    child: Text(
                                        '${controller.branchDetail.openingHours}',
                                        textDirection: TextDirection.ltr,
                                        style: AppTheme.lightStyle(
                                            color: Colors.black, size: Get.width * 0.04)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                             onTap:() async {
                                   String url =
                                       "tel://${controller.branchDetail.mobile}";
                                   if (await canLaunchUrl(Uri.parse(url))) {
                                     await launchUrl(Uri.parse(url));
                                   } else {
                                     throw 'Could not launch $url';
                                   }

                             },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConstant.branchCall,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                String destination =
                                    "${controller.branchDetail.latitude!},${controller.branchDetail.longitude!}";
                                if (Platform.isAndroid) {
                                  final AndroidIntent intent = AndroidIntent(
                                      action: 'action_view',
                                      data: Uri.encodeFull(
                                          "http://www.google.com/maps/place/$destination"),
                                      package: 'com.google.android.apps.maps');
                                  intent.launch();
                                } else {
                                  String url =
                                      "http://www.google.com/maps/place/$destination";
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  AssetsConstant.iconLocation,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
