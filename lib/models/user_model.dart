import 'dart:convert';

import 'error_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.sessionToken,
    this.isCompleted,
    this.isCustomer,
    this.hasReferral,
    this.userCode,
    this.isSucceeded,
    this.errors,
    this.accessToken,
    this.firstName,
    this.lastName,
  });

  String? sessionToken;
  bool? isCompleted;
  bool? isCustomer;
  bool? hasReferral;
  String? userCode;
  bool? isSucceeded;
  dynamic errors;
  String? accessToken;
  dynamic firstName;
  dynamic lastName;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    sessionToken: json["SessionToken"],
    isCompleted: json["IsCompleted"],
    isCustomer: json["IsCustomer"],
    hasReferral: json["HasReferral"],
    userCode: json["UserCode"],
    isSucceeded: json["IsSucceeded"],
    accessToken: json["AccessToken"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    errors: json["Errors"] == null
        ? null
        : List<ErrorModel>.from(
        json["Errors"].map((x) => ErrorModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SessionToken": sessionToken,
    "IsCompleted": isCompleted,
    "IsCustomer": isCustomer,
    "HasReferral": hasReferral,
    "UserCode": userCode,
    "IsSucceeded": isSucceeded,
    "AccessToken": accessToken,
    "FirstName": firstName,
    "LastName": lastName,
    "Errors": errors == null
        ? null
        : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}
