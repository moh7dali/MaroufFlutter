import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/viewmodel/signin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constant/assets_constant.dart';
import '../widgets/animated_shake_widget.dart';
import 'main_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final sakeKey = GlobalKey<ShakeWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: GetBuilder<SigninViewModel>(
          init: SigninViewModel(),
          builder: (controller) => Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child:
                    Image.asset(AssetsConstant.signupBack, fit: BoxFit.cover),
              ),
              Positioned(
                top: Get.height * .15,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Hero(
                            tag: 'logoTAg',
                            child: Image.asset(
                              AssetsConstant.splashLogo,
                              width: Get.width * .65,
                            )),
                        Material(
                          color: Colors.transparent,
                          child: Text(
                            'pleaseEnterYourMobileNumber'.tr,
                            style: AppTheme.lightStyle(
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .05,
                        ),
                        AnimatedOpacity(
                          opacity: controller.mainOpacity,
                          duration: const Duration(milliseconds: 800),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top:
                                        BorderSide(color: AppTheme.colorAccent),
                                        left:
                                        BorderSide(color: AppTheme.colorAccent),
                                        right:
                                        BorderSide(color: AppTheme.colorAccent),
                                        bottom: BorderSide(
                                            color: AppTheme.colorAccent, width: 2),
                                      )),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      Row(
                                        textDirection: TextDirection.ltr,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 8,left: 8),
                                            child: Text(
                                              '+962',
                                              style: AppTheme.lightStyle(
                                                  color: Colors.white),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * .1,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: ShakeWidget(
                                          key: sakeKey,
                                          shakeOffset: 10,
                                          shakeCount: 2,
                                          shakeDuration:
                                              const Duration(milliseconds: 800),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller:
                                                controller.phoneController,
                                            onChanged: (value) {
                                              if (value.startsWith('0')) {
                                                controller.phoneController.text
                                                    .replaceFirst('0', '');
                                              }
                                            },
                                            onFieldSubmitted: (Value) {
                                              formKey.currentState!.validate();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                sakeKey.currentState?.shake();
                                                controller.isPhone = true;
                                                controller.update();
                                              } else if (value.isPhoneNumber) {
                                                controller.isPhone = true;
                                                controller.sendCode();
                                                controller.update();
                                              } else {
                                                controller.isPhone = false;
                                                sakeKey.currentState?.shake();
                                                controller.update();
                                              }
                                              return null;
                                            },

                                            maxLength: 10,

                                            textDirection: TextDirection.ltr,
                                            style: AppTheme.lightStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'phoneNumber'.tr,
                                                counter: Container(
                                                  height: 0,
                                                ),
                                                hintTextDirection:
                                                    TextDirection.ltr,
                                                hintStyle: AppTheme.lightStyle(
                                                    color: Colors.white,size: 14.sp)),
                                          ),
                                        ),
                                      ),
                                      AnimatedOpacity(
                                          opacity: controller.isPhone ? 0 : 1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: const Icon(
                                            Icons.error,
                                            color: Color(
                                              0xffff0000,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  height: 2,
                                  width: Get.width,
                                  color: controller.isPhone
                                      ? AppTheme.colorAccent
                                      : const Color(
                                          0xffff0000,
                                        ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: controller.isPhone ? 0 : 1,
                                duration: const Duration(milliseconds: 500),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    color: Colors.white.withOpacity(.7),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('phone9Digit'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.white,
                                                  size: 15)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    controller.isPhone ? 0 : Get.height * .03,
                              ),
                            ],
                          ),
                        ),
                        Hero(
                          tag: 'buttonNext',
                          child: GestureDetector(
                            onTap: () {
                              formKey.currentState!.validate();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.colorAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'next'.tr,
                                    style: AppTheme.lightStyle(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     String url =
                        //         "https://Marouf.lazordclub.com/Marouf.WebAPI/privacy_policy.html";
                        //     launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
                        //     // if (await canLaunchUrl(Uri.parse(url))) {
                        //     //   await launchUrl(Uri.parse(url),mode: LaunchMode.platformDefault);
                        //     // } else {
                        //     //   throw 'Could not launch $url';
                        //     // }
                        //   },
                        //   child: Text(
                        //     'privacyPolicy'.tr,
                        //     style: AppTheme.lightStyle(
                        //         color: AppTheme.colorAccent),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: Get.height * .02,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(MainScreen(),
                                duration: const Duration(seconds: 1),
                                transition: Transition.fadeIn);
                          },
                          child: Text(
                            'skip'.tr,
                            style: AppTheme.lightStyle(
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
