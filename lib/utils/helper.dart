import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/main.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/widgets/add_to_cart_dialog.dart';

class Helper {
  void addToCartDialog(BuildContext context, {bool isTop = false}) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => AddToCartDialog(isTop: isTop),
    );
  }

  void loading() {
    if (Platform.isIOS) {
      Get.dialog(
          AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('loading'.tr),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      Text('pleaseWait'.tr)
                    ],
                  ),
                ),
              ],
            ),
          ),
          barrierColor:
              AppTheme.lightTheme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: true);
    } else {
      Get.dialog(
          AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('loading'.tr),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      Text('pleaseWait'.tr)
                    ],
                  ),
                ),
              ],
            ),
          ),
          barrierColor:
              AppTheme.lightTheme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: true);
    }
  }

  void actionDialog(
    String title,
    String body, {
    VoidCallback? confirm,
    VoidCallback? cancel,
    String? confirmText,
    String? cancelText,
  }) {
    Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    style: AppTheme.boldStyle(color: Colors.black, size: 14)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                      child: Text(
                        body,
                        style:
                            AppTheme.lightStyle(color: Colors.black, size: 14),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: confirm,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              confirmText ?? 'confirm'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.width * 0.03),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: cancel,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cancelText ?? 'Cancel'.tr,
                              style: TextStyle(fontSize: Get.width * 0.03),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        barrierColor:
            AppTheme.lightTheme.scaffoldBackgroundColor.withOpacity(0.6),
        barrierDismissible: true);
  }

  void actionOneBtnDialoge(
    String title,
    String body, {
    VoidCallback? cancel,
    String? cancelText,
  }) {
    Get.dialog(
        AlertDialog(
          title: Text(title),
          titleTextStyle: AppTheme.boldStyle(color: Colors.black, size: 18.sp),
          contentPadding: EdgeInsets.all(0),
          // shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 15, right: 10),
                      child: Text(
                        body,
                        style: AppTheme.lightStyle(
                            color: Colors.black, size: 15.sp),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width * .1, Get.height * .04),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    side: BorderSide(width: 1, color: Colors.black)),
              ),
              onPressed: () {
                cancel!();
              },
              child: Text(
                cancelText ?? 'Cancel'.tr,
                style: AppTheme.lightStyle(color: Colors.black, size: 14),
              ),
            ),
          ],
        ),
        barrierColor:
            AppTheme.lightTheme.scaffoldBackgroundColor.withOpacity(0.6),
        barrierDismissible: true);
  }

  successfullySnackBar(String message, {Icon? icon}) {

    Fluttertoast.cancel().then((value) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });

    // Get.snackbar(
    //   "",
    //   message,
    //   titleText: Container(
    //     height: 0,
    //   ),
    //   backgroundColor: Colors.white,
    //   icon: icon ??
    //       const Icon(
    //         Icons.check_circle,
    //         color: Colors.green,
    //       ),
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  errorSnackBar(String message,
      {Icon? icon, bool isPend = false, bool isTop = false}) {
    Get.snackbar(
      "",
      message,
      padding: isPend ? EdgeInsets.all(30) : null,
      duration: isPend ? Duration(minutes: 1) : Duration(seconds: 2),
      titleText: Container(
        height: 0,
      ),
      borderColor: Colors.red,
      borderWidth: 1,
      borderRadius: 20,
      backgroundColor: Colors.white,
      mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('done'.tr)),
      icon: icon ??
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
