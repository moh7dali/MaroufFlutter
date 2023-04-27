import 'dart:io';

import 'package:Marouf/models/package_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  IosDeviceInfo? iosDeviceInfo;
  PackageAppInfo? packageAppInfo;
  AndroidDeviceInfo? androidDeviceInfo;

  DeviceInfo() {
    PackageInfo.fromPlatform().then((value) {
      packageAppInfo = PackageAppInfo(value.appName, value.packageName,
          value.version, value.buildNumber, value.buildSignature);
print(value.packageName);
      getDeviceInfo();
    });
  }

  Future<dynamic> getDeviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    } else if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
    }
  }
}
