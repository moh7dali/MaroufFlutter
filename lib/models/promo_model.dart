import 'package:Marouf/models/main_response.dart';

class PromoModel {
  final int? promotionCodeStatus;
  final int? promotionType;
  final int? promotionActionType;
  final double? value;
  final double? minimumOrderAmount;
  final String? productName;
  final String? productImageUrl;
  final int? productId;
  final double? maximumAmount;
  final String? errorMessage;
  final bool? isSucceeded;
  final List<Error>? errors;

  PromoModel({
    this.promotionCodeStatus,
    this.promotionType,
    this.promotionActionType,
    this.value,
    this.minimumOrderAmount,
    this.productName,
    this.productImageUrl,
    this.productId,
    this.maximumAmount,
    this.errorMessage,
    this.isSucceeded,
    this.errors,
  });

  PromoModel.fromJson(Map<String, dynamic> json)
      : promotionCodeStatus = json['PromotionCodeStatus'] as int?,
        promotionType = json['PromotionType'] as int?,
        promotionActionType = json['PromotionActionType'] as int?,
        value = json['Value'] as double?,
        minimumOrderAmount = json['MinimumOrderAmount'] as double?,
        productName = json['ProductName'] as String?,
        productImageUrl = json['ProductImageUrl'] as String?,
        productId = json['ProductId'] as int?,
        maximumAmount = json['MaximumAmount'] as double?,
        errorMessage = json['ErrorMessage'] as String?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'PromotionCodeStatus' : promotionCodeStatus,
    'PromotionType' : promotionType,
    'PromotionActionType' : promotionActionType,
    'Value' : value,
    'MinimumOrderAmount' : minimumOrderAmount,
    'ProductName' : productName,
    'ProductImageUrl' : productImageUrl,
    'ProductId' : productId,
    'MaximumAmount' : maximumAmount,
    'ErrorMessage' : errorMessage,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}
