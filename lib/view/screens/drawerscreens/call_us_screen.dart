import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:Marouf/viewmodel/call_us_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../utils/theme/app_theme.dart';

class CallUsScreen extends StatelessWidget {
  const CallUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CallUsViewModel>(
        init: CallUsViewModel(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(AssetsConstant.contactUsBack,
                      fit: BoxFit.cover),
                ),
                AppBar(
                  centerTitle: false,
                  backgroundColor: Colors.transparent,

                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text('contactUs'.tr,
                      style: AppTheme.boldStyle(color: Colors.white, size: 20)),
                ),
                Positioned(
                  top: Get.height * .15,
                  left: 12,
                  right: 12,
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white.withOpacity(.2),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 12, right: 12),
                              child: ShakeWidget(
                                key: controller.sakeKey,
                                shakeOffset: 10,
                                shakeCount: 2,
                                shakeDuration:
                                    const Duration(milliseconds: 800),
                                child: TextFormField(
                                  controller: controller.email,
                                  style: AppTheme.lightStyle(
                                      color: Colors.white, size: 20),
                                  validator: (value) {
                                    if (value!.isEmail) {
                                      return null;
                                    } else {
                                      controller.sakeKey.currentState!.shake();
                                      return 'invalidEmail'.tr;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      label: Text('yourEmail'.tr,
                                          style: AppTheme.lightStyle(
                                              color: Colors.white,
                                              size: 20)),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2)),
                                      errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2)),
                                      focusedErrorBorder:
                                          const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2)),
                                      errorStyle: AppTheme.lightStyle(
                                          color: Colors.white,
                                          size: 16)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            color:Colors.white.withOpacity(.2),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 12, right: 12),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    return null;
                                  } else {
                                    controller.sakeKey.currentState!.shake();
                                    return 'fillMessage'.tr;
                                  }
                                },
                                controller: controller.message,
                                maxLines: 4,
                                style: AppTheme.lightStyle(
                                    color: Colors.white, size: 20),
                                decoration: InputDecoration(
                                    label: Text('writeMessage'.tr,
                                        style: AppTheme.lightStyle(
                                            color: Colors.white,
                                            size: 20)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2)),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2)),
                                    focusedErrorBorder:
                                    const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2)),
                                    errorStyle: AppTheme.lightStyle(
                                        color: Colors.white, size: 16)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if(controller.formKey.currentState!.validate()){
                                controller.sendMessage();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:AppTheme.colorAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 6),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'send'.tr,
                                    style: AppTheme.lightStyle(
                                      color: Colors.white ,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('orContactUsVia'.tr,
                                  style: AppTheme.lightStyle(
                                      color: Colors.white, size: 20)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Uri uri = Uri.parse(
                                      "tel:${controller.contactInfo.contactCallNumber!}");
                                  if (!await launchUrl(uri)) {
                                    throw 'Could not launch $uri';
                                  }
                                },
                                child: Image.asset(
                                  AssetsConstant.callIcon,
                                  height: 50.h,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Uri uri=Uri();
                                    uri= Uri.parse("https://api.whatsapp.com/send/?phone=${controller.contactInfo.contactWhatsAppNumber}");
                                  if (!await launchUrl(uri,mode: LaunchMode.externalApplication)) {
                                    throw 'Could not launch $uri';
                                  }
                                },
                                child: Image.asset(
                                  AssetsConstant.whatsappIcon,
                                  height: 50.h,
                                ),
                              ),

                            ],
                          )
                        ],
                      )),
                )
              ],
            ),
          );
        });
  }
}
