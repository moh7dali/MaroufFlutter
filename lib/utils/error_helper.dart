import 'package:intl/intl.dart';
import 'package:Marouf/main.dart';

import '../models/order_model.dart';

class ErrorHelper {
  final int code;
  String message;
  final OrderModel orderModel;

  ErrorHelper(this.code, this.message, this.orderModel);

  String handleError() {
    String newMessage = message;
    switch (code) {
      case 21: //OutOfStockItem
        return newMessage.replaceAll(ErrorConstant.outOfStockItem,
            '\n ${orderModel.outOfStockItem!.map((e) => ' — ${e.productName}').toList().join(' \n ')}');
      case 37: //Order time unavailable
        return newMessage
            .replaceAll(
            ErrorConstant.fromDate,
            //     orderModel.orderPossibilityResult!.fromDate!)
            // .replaceAll(ErrorConstant.toDate,
            //     orderModel.orderPossibilityResult!.toDate!);
            formatDuration(orderModel.orderPossibilityResult!.fromDate!))
            .replaceAll(ErrorConstant.toDate,
            formatDuration(orderModel.orderPossibilityResult!.toDate!));
      case 45: // ReasonForStoppingOrder
        return newMessage.replaceAll(ErrorConstant.reasonForStoppingOrder,
            orderModel.orderPossibilityResult!.reasonForStoppingOrder!);
      case 47: //Order delivery time unavailable
        return newMessage
            .replaceAll(
            ErrorConstant.deliveryFromDate,
            formatDuration(
                orderModel.orderPossibilityResult!.deliveryFromDate!))
            .replaceAll(
            ErrorConstant.deliveryToDate,
            formatDuration(
                orderModel.orderPossibilityResult!.deliveryToDate!));
      case 55: //category unavailable
        return newMessage.replaceAll(ErrorConstant.unavailableItems,
            '\n ${orderModel.unavailableItems!.map((e) => ' — ${e.productName}: ${formatDuration(e.displayStartTime!)} - ${formatDuration(e.displayEndTime!)}').toList().join(' \n ')}');
      case 52:
        return newMessage.replaceAll(ErrorConstant.unavailableItems,
            '\n ${orderModel.unavailableItems!.map((e) => ' — ${e.productName}').toList().join(' \n ')}');
      case 53: //inactive per branch
      case 82: //hasOnlineOrder -false-
      case 88: //unavailableItems
        return newMessage;
    // .replaceAll(ErrorConstant.unavailableItems,
    // '\n ${orderModel.unavailableItems!.map((e) => ' — ${e.productName}').toList().join(' \n ')}');
      case 71: //unavailableOptionsItems
        return newMessage.replaceAll(ErrorConstant.unavailableOptionsItems,
            '\n ${orderModel.unavailableOptionItems!.map((e) => ' — ${e.productName} (${e.optionItemName})').toList().join(' \n ')}');
      default:
        return newMessage;
    }
  }
}

String formatDuration(String time) {
  DateFormat f = DateFormat('HH:mma');
  DateTime formattedTime = f.parse(time);
  String formattedTime12 = appLanguage == 'ar'
      ? (DateFormat.jm().format(formattedTime))
      .toLowerCase()
      .replaceAll('am', 'صباحاً')
      .replaceAll('pm', 'مساءً')
      : DateFormat.jm().format(formattedTime);
  print("${formattedTime12}_______________");
  return formattedTime12;
}

class ErrorConstant {
  static const String fromDate = '{FromDate}';
  static const String toDate = '{ToDate}';
  static const String unavailableItems = '{UnavailableItems}';
  static const String unavailableOptionsItems = '{UnavailableOptionItems}';
  static const String deliveryFromDate = '{DeliveryFromDate}';
  static const String deliveryToDate = '{DeliveryToDate}';
  static const String preOrderPeriod = '{PreOrderPeriod}';
  static const String outOfStockItem = '{OutOfStockItem}';
  static const String reasonForStoppingOrder = '{ReasonForStoppingOrder}';
  static const String isBusyBrand = '{IsBusyBrand}';
}
