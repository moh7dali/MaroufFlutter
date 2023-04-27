import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/date_picker_widget.dart';
import 'package:Marouf/viewmodel/referral_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/animated_shake_widget.dart';
import 'main_screen.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ReferralViewModel>(
        init: ReferralViewModel(),
        builder: (controller) =>
            Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child:
                  Image.asset(AssetsConstant.inviteBack, fit: BoxFit.cover),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: Get.height * .15,
                    bottom: 0,
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Hero(
                              tag: 'logoTAg',
                              child: Image.asset(
                                AssetsConstant.splashLogo,
                                width: Get.width * .5,
                              )),
                          SizedBox(height: Get.height * .05),
                          Align(
                            alignment: Alignment.center,
                            child: Text('referralCode'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.white, size: 18.sp)
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('referralMessage'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.white, size: 15.sp),textAlign:TextAlign.center ,),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ShakeWidget(
                            key: controller.referralKey,
                            shakeOffset: 10,
                            shakeCount: 2,
                            shakeDuration: const Duration(milliseconds: 800),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization
                                    .sentences,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.name,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  if (controller.referralController.text !=
                                      value.toUpperCase())
                                    controller.referralController.value =
                                        controller
                                            .referralController.value
                                            .copyWith(
                                            text: value.toUpperCase());
                                },
                                controller: controller.referralController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    controller.referralValidate = true;
                                    controller.update();
                                  } else {
                                    controller.referralValidate = false;
                                    controller.update();
                                  }

                                  return null;
                                },
                                maxLength: 9,
                                textDirection: TextDirection.ltr,
                                style: AppTheme.lightStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    hintText: 'referralCode'.tr,
                                    alignLabelWithHint: true,
                                    counter: Container(
                                      height: 0,
                                    ),
                                    hintTextDirection: TextDirection.ltr,
                                    hintStyle:
                                    AppTheme.lightStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Hero(
                            tag: 'buttonNext',
                            child: GestureDetector(
                              onTap: () {
                                controller.formKey.currentState!.validate();
                                controller.save();
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
                                      'save'.tr,
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
                          GestureDetector(
                            onTap: () {
                              Get.offAll(MainScreen(),
                                  duration: const Duration(seconds: 1),
                                  transition: Transition.fadeIn);
                            },
                            child: Text(
                              'skip'.tr,
                              style: AppTheme.lightStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
      ),
    );
  }
}
