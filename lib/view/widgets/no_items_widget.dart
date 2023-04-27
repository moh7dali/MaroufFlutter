import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/no_item_viewmodel.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget(
      {Key? key,
        required this.img,
        required this.title,
        this.body,
        this.hasColor = true,
        this.isSmall = false})
      : super(key: key);
  final String img;
  final String title;
  final String? body;
  final bool isSmall;
  final bool hasColor;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoItemViewModel>(
        init: NoItemViewModel(),
        builder: (controller) {
          return isSmall
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Container(
                  height: Get.width * .3,
                  width: Get.width * .3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.colorAccent, width: 1.6),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: controller.isNoItemAnimate
                            ? Get.width * .06
                            : Get.width * .3,
                        left: 0,
                        right: 0,
                        bottom: controller.isNoItemAnimate
                            ? Get.width * .06
                            : 0,
                        duration: const Duration(seconds: 1),
                        child: AnimatedOpacity(
                          opacity: controller.isNoItemAnimate ? 1 : 0,
                          duration: const Duration(seconds: 2),
                          child: Image.asset(
                            img,
                            color: hasColor ? AppTheme.colorPrimary : null,
                            height: Get.width * .2,
                            width: Get.width * .2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  padding: EdgeInsets.only(
                    top: controller.isNoItemAnimate ? 8 : 30,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  child: AnimatedOpacity(
                    opacity: controller.isNoItemAnimate ? 1 : 0,
                    duration: const Duration(seconds: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: AppTheme.boldStyle(
                              color: AppTheme.colorAccent, size: 18.sp),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            body ?? "",
                            textAlign: TextAlign.center,
                            style: AppTheme.lightStyle(
                                color: AppTheme.colorAccent, size: 18.sp),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: Get.height * .2),
              Center(
                child: Container(
                  height: Get.width * .5,
                  width: Get.width * .5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.colorAccent, width: 1.6),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: controller.isNoItemAnimate
                            ? Get.width * .06
                            : Get.width * .4,
                        left: 0,
                        right: 0,
                        bottom: controller.isNoItemAnimate
                            ? Get.width * .06
                            : 0,
                        duration: const Duration(seconds: 1),
                        child: AnimatedOpacity(
                          opacity: controller.isNoItemAnimate ? 1 : 0,
                          duration: const Duration(seconds: 2),
                          child: Image.asset(
                            img,
                            color: hasColor ? AppTheme.colorPrimary : null,
                            height: Get.width * .25,
                            width: Get.width * .25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  padding: EdgeInsets.only(
                    top: controller.isNoItemAnimate ? 8 : 30,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  child: AnimatedOpacity(
                    opacity: controller.isNoItemAnimate ? 1 : 0,
                    duration: const Duration(seconds: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: AppTheme.boldStyle(
                              color: AppTheme.colorAccent, size: 18.sp),
                        ),
                        Text(
                          body ?? "",
                          textAlign: TextAlign.center,
                          style: AppTheme.lightStyle(
                              color: Colors.black, size: 18.sp),
                        )
                      ],
                    ),
                  ))
            ],
          );
        });
  }
}
