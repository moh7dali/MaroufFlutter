import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/viewmodel/call_us_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../utils/theme/app_theme.dart';

class ConnectWithUsScreen extends StatelessWidget {
  ConnectWithUsScreen({Key? key}) : super(key: key);

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
                  child: Image.asset(AssetsConstant.connectUsBack,
                      fit: BoxFit.cover),
                ),
                AppBar(
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text('connectWithUs'.tr,
                      style: AppTheme.lightStyle(color: Colors.white, size: 20)),
                ),
                Positioned(
                    top: Get.height * .15,
                    left: 12,
                    right: 12,
                    bottom: 0,
                    child: Column(
                      children: [
                        Image.asset(
                          AssetsConstant.splashLogo,
                          width: Get.width * .5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        socialCard(
                            title: 'facebook'.tr,
                            // color: Colors.transparent,
                            link: 'https://www.facebook.com/Maroufchicken',
                            mode: LaunchMode.externalApplication,
                            icon: AssetsConstant.facebook
                        ),
                        socialCard(
                            title: 'instagram'.tr,
                            // color: Colors.transparent,
                            link: 'https://instagram.com/Maroufchicken/',
                            mode: LaunchMode.externalApplication,
                            icon: AssetsConstant.instagram),
                        socialCard(
                            title: 'website'.tr,
                            // color: Colors.transparent,
                            link: 'https://www.maroufcoffee.com/',
                            mode: LaunchMode.externalApplication,
                            icon: AssetsConstant.website),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  Widget socialCard({
    required String? title,
    required String? link,
    required String? icon,
    // required Color? color,
    required LaunchMode? mode,
  }) {
    return GestureDetector(
      onTap: ()async {
        if (!await launchUrl(Uri.parse(link!),mode: mode!,)) throw 'Could not launch $link';
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            // color: color,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Row(children: [
              Image.asset(
                icon!,
                width: Get.width *.2,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title!, style: AppTheme.lightStyle(color: Colors.white, size: 18.sp)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
