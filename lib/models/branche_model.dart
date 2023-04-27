// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

import 'package:Marouf/models/main_response.dart';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  BranchModel({
    this.branchModel,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  List<BranchModelElement>? branchModel;
  bool? isSucceeded;
  List<Error>? errors;
  int? totalNumberofResult;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    branchModel: json["BranchModel"] == null ? [] : List<BranchModelElement>.from(json["BranchModel"].map((x) => BranchModelElement.fromJson(x))),
    isSucceeded: json["IsSucceeded"] == null ? null : json["IsSucceeded"],
    errors: json["Errors"] == null ? null : List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
    totalNumberofResult: json["TotalNumberofResult"] == null ? null : json["TotalNumberofResult"],
  );

  Map<String, dynamic> toJson() => {
    "BranchModel": branchModel == null ? null : List<dynamic>.from(branchModel!.map((x) => x.toJson())),
    "IsSucceeded": isSucceeded == null ? null : isSucceeded,
    "Errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
    "TotalNumberofResult": totalNumberofResult == null ? null : totalNumberofResult,
  };
}

class BranchModelElement {
  BranchModelElement({
    this.id,
    this.name,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.hasOnlinePayment,
  });

  int? id;
  String? name;
  dynamic imageUrl;
  dynamic latitude;
  dynamic longitude;
  bool? hasOnlinePayment;

  factory BranchModelElement.fromJson(Map<String, dynamic> json) => BranchModelElement(
    id: json["Id"] == null ? null : json["Id"],
    name: json["Name"] == null ? null : json["Name"],
    imageUrl: json["ImageUrl"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    hasOnlinePayment: json["HasOnlinePayment"] == null ? null : json["HasOnlinePayment"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "Name": name == null ? null : name,
    "ImageUrl": imageUrl,
    "Latitude": latitude,
    "Longitude": longitude,
    "HasOnlinePayment": hasOnlinePayment == null ? null : hasOnlinePayment,
  };
}
