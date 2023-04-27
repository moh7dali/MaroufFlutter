import 'package:flutter/services.dart';

class GoogleHuaweiService{

  static const MethodChannel methodChannel =
  MethodChannel('com.mozaic.www.maroufcoffee/isHmsGmsAvailable');

  Future<bool> isHMS() async {
    bool status=false;

    try {
      bool result = await methodChannel.invokeMethod('isHmsAvailable');
      status = result;
      print('status : ${status.toString()}');
    } on PlatformException {
      print('Failed to get _isHmsAvailable.');
    }

   return status;

  }

  Future<bool> isGMS() async {
    bool status=false;

    try {
      bool result = await methodChannel.invokeMethod('isGmsAvailable');
      status = result;
      print('status : ${status.toString()}');
    } on PlatformException {
      print('Failed to get _isGmsAvailable.');
    }

    return status;

  }
}