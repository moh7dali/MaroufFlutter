import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import 'helper.dart';

class LocationHelper {
  static Future requestLocationPermission(VoidCallback callback) async {
    Geolocator.requestPermission().then((value) async {
      await Geolocator.checkPermission().then((value) {
        if (value == LocationPermission.always ||
            value == LocationPermission.whileInUse) {
          Geolocator.getLastKnownPosition().then((location) async {
            callback();
          });
        } else {
          if (kDebugMode) {
            print('valueLocation: $value');
          }
          Geolocator.requestPermission().then((permissionStatus) {
            if (permissionStatus != LocationPermission.always &&
                permissionStatus != LocationPermission.whileInUse) {
              Helper().actionDialog('permissionNotAllowed'.tr,
                  'locationPermissionShouldAllowed'.tr,
                  cancelText: 'doneClose'.tr,
                  confirmText: 'openAppSettings'.tr, confirm: () async {
                Get.back();

                if (Platform.isIOS) {
                  if (await Geolocator.isLocationServiceEnabled()) {
                    openAppSettings();
                  } else {
                    openLocationSetting();
                  }
                } else {
                  openAppSettings();
                }
              }, cancel: () {
                Get.back();
              });
            }
          });
        }
      });
    });
  }
}
