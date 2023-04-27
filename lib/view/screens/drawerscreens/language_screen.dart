import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/viewmodel/language_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/assets_constant.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LanguageViewModel>(
          init: LanguageViewModel(),
          builder: (controller) {
            return  Stack(
              children: [
              Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(AssetsConstant.connectUsBack,
                  fit: BoxFit.cover),
            ),
            AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
              title: Text('Language'.tr,
                  style: AppTheme.lightStyle(color: Colors.white, size: 20)),

            ),
            Positioned(
            top: Get.height * .0001,
            left: 12,
            right: 12,
            bottom: 0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.changeLanguage('ar');
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: controller.currentLang == 'ar'
                                      ? Colors.black.withOpacity(.3)
                                      : AppTheme.colorAccent,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    'العربية',
                                    style: AppTheme.lightStyle(
                                        color: Colors.white, size: 20.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * .025),
                  GestureDetector(
                    onTap: () {
                      controller.changeLanguage('en');
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: controller.currentLang == 'en'
                                      ? Colors.black.withOpacity(.3)
                                      : AppTheme.colorAccent,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    'English',
                                    style: AppTheme.lightStyle(
                                        color: Colors.white, size: 20.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )]);
          }),
    );
  }
}
