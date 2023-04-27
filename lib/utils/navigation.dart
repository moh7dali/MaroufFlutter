import 'package:get/get.dart';

class NavigationApp {
  /// Similar to **Navigation.push()**
  static Future<T?> to<T>(dynamic page,
      {dynamic arguments, int? milliseconds}) async {
    return await Get.to(
      page,
      arguments: arguments,
      transition: Transition.fadeIn,
      duration: Duration(milliseconds: milliseconds ?? 600),
    );
  }

  /// Similar to **Navigation.pop**
  static back<T>() {
    return Get.back();
  }

  /// Similar to **Navigation.pushReplacement**
  static Future<dynamic> off(dynamic page,
      {dynamic arguments, int? milliseconds}) async {
    Get.off(
      page,
      arguments: arguments,
      transition: Transition.fadeIn,
      duration: Duration(milliseconds: milliseconds ?? 600),
    );
  }

  /// Similar to **Navigation.pushAndRemoveUntil()**
  static Future<dynamic> offUntil(dynamic page, {int? milliseconds}) async {
    Get.offAll(
      page,
      transition: Transition.fadeIn,
      duration: Duration(milliseconds: milliseconds ?? 600),
    );
  }
}
