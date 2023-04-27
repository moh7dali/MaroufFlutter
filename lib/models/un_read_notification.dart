// To parse this JSON data, do
//
//     final unReadNotification = unReadNotificationFromJson(jsonString);

import 'dart:convert';

import 'error_model.dart';

UnReadNotification unReadNotificationFromJson(String str) => UnReadNotification.fromJson(json.decode(str));

String unReadNotificationToJson(UnReadNotification data) => json.encode(data.toJson());

class UnReadNotification {
  UnReadNotification({
    this.hasDialogReward,
    this.homeTitle,
    this.orderPossibilityResult,
    this.userReward,
    this.data,
    this.isSucceeded,
    this.errors,
  });

  bool? hasDialogReward;
  String? homeTitle;
  Map<String, dynamic>? orderPossibilityResult;
  dynamic userReward;
  int? data;
  bool? isSucceeded;
  List<ErrorModel>? errors;

  factory UnReadNotification.fromJson(Map<String, dynamic> json) => UnReadNotification(
    hasDialogReward: json["HasDialogReward"] == null ? null : json["HasDialogReward"],
    homeTitle: json["HomeTitle"] == null ? null : json["HomeTitle"],
    orderPossibilityResult: json["OrderPossibilityResult"] == null ? null : Map.from(json["OrderPossibilityResult"]).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)),
    userReward: json["UserReward"],
    data: json["Data"] == null ? null : json["Data"],
    isSucceeded: json["IsSucceeded"] == null ? null : json["IsSucceeded"],
    errors: json["Errors"] == null
        ? null
        : List<ErrorModel>.from(
        json["Errors"].map((x) => ErrorModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "HasDialogReward": hasDialogReward == null ? null : hasDialogReward,
    "HomeTitle": homeTitle == null ? null : homeTitle,
    "OrderPossibilityResult": orderPossibilityResult == null ? null : Map.from(orderPossibilityResult!).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)),
    "UserReward": userReward,
    "Data": data == null ? null : data,
    "IsSucceeded": isSucceeded == null ? null : isSucceeded,
    "Errors": errors == null
        ? null
        : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}
