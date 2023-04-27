import 'dart:convert';

import 'package:Marouf/models/main_response.dart';

UserLoyalty userLoyaltyFromJson(String str) =>
    UserLoyalty.fromJson(json.decode(str));

String userLoyaltyToJson(UserLoyalty data) => json.encode(data.toJson());

class UserLoyalty {
  UserLoyalty({
    this.balance,
    this.purchaseAmount,
    this.numberOfVisits,
    this.redeemedPoints,
    this.expiredPoints,
    this.redeemConvertionData,
    this.addConvertionData,
    this.currencyDisplayName,
    this.numberOfOrders,
    this.currentTier,
    this.tierData,
    this.tierDefinitions,
    this.creationDate,
    this.fullName,
    this.totalActiveRewards,
    this.isSucceeded,
    this.errors,
  });

  int? balance;
  double? purchaseAmount;
  int? numberOfVisits;
  int? redeemedPoints;
  int? expiredPoints;
  ConvertionData? redeemConvertionData;
  ConvertionData? addConvertionData;
  String? currencyDisplayName;
  int? numberOfOrders;
  int? currentTier;
  TierData? tierData;
  List<TierDefinition>? tierDefinitions;
  DateTime? creationDate;
  String? fullName;
  int? totalActiveRewards;
  bool? isSucceeded;
  List<Error>? errors;

  factory UserLoyalty.fromJson(Map<String, dynamic> json) => UserLoyalty(
        balance: json["Balance"],
        purchaseAmount: json["PurchaseAmount"],
        numberOfVisits: json["NumberOfVisits"],
        redeemedPoints: json["RedeemedPoints"],
        expiredPoints: json["ExpiredPoints"],
        redeemConvertionData: json["RedeemConvertionData"] == null
            ? null
            : ConvertionData.fromJson(json["RedeemConvertionData"]),
        addConvertionData: json["AddConvertionData"] == null
            ? null
            : ConvertionData.fromJson(json["AddConvertionData"]),
        currencyDisplayName: json["CurrencyDisplayName"],
        numberOfOrders: json["NumberOfOrders"],
        currentTier: json["CurrentTier"],
        tierData: json["TierData"] == null
            ? null
            : TierData.fromJson(json["TierData"]),
        tierDefinitions: json["TierDefinitions"] == null
            ? null
            : List<TierDefinition>.from(
                json["TierDefinitions"].map((x) => TierDefinition.fromJson(x))),
        creationDate: json["CreationDate"] == null
            ? null
            : DateTime.parse(json["CreationDate"]),
        fullName: json["FullName"],
        totalActiveRewards: json["TotalActiveRewards"],
        isSucceeded: json["IsSucceeded"],
        errors: json["Errors"] == null
            ? null
            : List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Balance": balance,
        "PurchaseAmount": purchaseAmount,
        "NumberOfVisits": numberOfVisits,
        "RedeemedPoints": redeemedPoints,
        "ExpiredPoints": expiredPoints,
        "RedeemConvertionData": redeemConvertionData == null
            ? null
            : redeemConvertionData!.toJson(),
        "AddConvertionData":
            addConvertionData == null ? null : addConvertionData!.toJson(),
        "CurrencyDisplayName": currencyDisplayName,
        "NumberOfOrders": numberOfOrders,
        "CurrentTier": currentTier,
        "TierData": tierData == null ? null : tierData!.toJson(),
        "TierDefinitions": tierDefinitions == null
            ? null
            : List<dynamic>.from(tierDefinitions!.map((x) => x.toJson())),
        "CreationDate":
            creationDate == null ? null : creationDate!.toIso8601String(),
        "FullName": fullName,
        "TotalActiveRewards": totalActiveRewards,
        "IsSucceeded": isSucceeded,
        "Errors": errors == null
            ? null
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class ConvertionData {
  ConvertionData({
    this.numberOfPoints,
    this.equivalentCashAmountPerUnit,
  });

  int? numberOfPoints;
  int? equivalentCashAmountPerUnit;

  factory ConvertionData.fromJson(Map<String, dynamic> json) => ConvertionData(
        numberOfPoints: json["NumberOfPoints"],
        equivalentCashAmountPerUnit: json["EquivalentCashAmountPerUnit"],
      );

  Map<String, dynamic> toJson() => {
        "NumberOfPoints": numberOfPoints,
        "EquivalentCashAmountPerUnit": equivalentCashAmountPerUnit,
      };
}

class TierData {
  TierData({
    this.purchaseAmount,
    this.upperTierAmount,
    this.tierName,
    this.tierExpiryDate,
    this.tierDiscount,
    this.tierPercent,
  });

  double? purchaseAmount;
  double? upperTierAmount;
  String? tierName;
  DateTime? tierExpiryDate;
  double? tierDiscount;
  double? tierPercent;

  factory TierData.fromJson(Map<String, dynamic> json) => TierData(
        purchaseAmount: json["PurchaseAmount"],
        upperTierAmount: json["UpperTierAmount"],
        tierName: json["TierName"],
        tierExpiryDate: json["TierExpiryDate"] == null
            ? null
            : DateTime.parse(json["TierExpiryDate"]),
        tierDiscount: json["TierDiscount"],
        tierPercent: json["TierPercent"],
      );

  Map<String, dynamic> toJson() => {
        "PurchaseAmount": purchaseAmount,
        "UpperTierAmount": upperTierAmount,
        "TierName": tierName,
        "TierExpiryDate":
            tierExpiryDate == null ? null : tierExpiryDate!.toIso8601String(),
        "TierDiscount": tierDiscount,
        "TierPercent": tierPercent,
      };
}

class TierDefinition {
  TierDefinition({
    this.id,
    this.lowerLimit,
    this.name,
    this.discount,
    this.percent,
  });

  int? id;
  double? lowerLimit;
  String? name;
  double? discount;
  double? percent;

  factory TierDefinition.fromJson(Map<String, dynamic> json) => TierDefinition(
        id: json["Id"],
        lowerLimit: json["LowerLimit"],
        name: json["Name"],
        discount: json["Discount"],
        percent: json["Percent"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "LowerLimit": lowerLimit,
        "Name": name,
        "Discount": discount,
        "Percent": percent,
      };
}
