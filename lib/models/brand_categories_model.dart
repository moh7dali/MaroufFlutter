// To parse this JSON data, do
//
//     final brandCategories = brandCategoriesFromJson(jsonString);

import 'dart:convert';

import 'package:Marouf/models/main_response.dart';

import 'home_model.dart';


BrandCategories brandCategoriesFromJson(String str) => BrandCategories.fromJson(json.decode(str));

String brandCategoriesToJson(BrandCategories data) => json.encode(data.toJson());
class BrandCategories {
  final bool? isOpen;
  final String? openingHours;
  final dynamic mostPopularImageUrl;
  final dynamic mostPopularText;
  final bool? hasDailyDish;
  final int? brandId;
  final String? brandName;
  final String? brandImageUrl;
  final dynamic brandLogoUrl;
  final dynamic brandDescription;
  final double? brandDiscount;
  final dynamic brandMarketingText;
  final dynamic brandMinAmountToSpend;
  final dynamic brandMaxAmountToSpend;
  final dynamic brandClassifications;
  final int? numberOfOrderRate;
  final dynamic brandLabel;
  final List<RootCategories>? categoryModel;
  final bool? canOrder;
  final List<dynamic>? brandRateDetails;
  final double? orderRate;
  final bool? deliveredByUs;
  final dynamic freeDeliveryFeesText;
  final bool? isSucceeded;
  final List<Error>? errors;
  final int? totalNumberofResult;

  BrandCategories({
    this.isOpen,
    this.openingHours,
    this.mostPopularImageUrl,
    this.mostPopularText,
    this.hasDailyDish,
    this.brandId,
    this.brandName,
    this.brandImageUrl,
    this.brandLogoUrl,
    this.brandDescription,
    this.brandDiscount,
    this.brandMarketingText,
    this.brandMinAmountToSpend,
    this.brandMaxAmountToSpend,
    this.brandClassifications,
    this.numberOfOrderRate,
    this.brandLabel,
    this.categoryModel,
    this.canOrder,
    this.brandRateDetails,
    this.orderRate,
    this.deliveredByUs,
    this.freeDeliveryFeesText,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  BrandCategories.fromJson(Map<String, dynamic> json)
      : isOpen = json['IsOpen'] as bool?,
        openingHours = json['OpeningHours'] as String?,
        mostPopularImageUrl = json['MostPopularImageUrl'],
        mostPopularText = json['MostPopularText'],
        hasDailyDish = json['HasDailyDish'] as bool?,
        brandId = json['BrandId'] as int?,
        brandName = json['BrandName'] as String?,
        brandImageUrl = json['BrandImageUrl'] as String?,
        brandLogoUrl = json['BrandLogoUrl'],
        brandDescription = json['BrandDescription'],
        brandDiscount = json['BrandDiscount'] as double?,
        brandMarketingText = json['BrandMarketingText'],
        brandMinAmountToSpend = json['BrandMinAmountToSpend'],
        brandMaxAmountToSpend = json['BrandMaxAmountToSpend'],
        brandClassifications = json['BrandClassifications'],
        numberOfOrderRate = json['NumberOfOrderRate'] as int?,
        brandLabel = json['BrandLabel'],
        categoryModel = (json['CategoryModel'] as List?)?.map((dynamic e) => RootCategories.fromJson(e as Map<String,dynamic>)).toList(),
        canOrder = json['CanOrder'] as bool?,
        brandRateDetails = json['BrandRateDetails'] as List?,
        orderRate = json['OrderRate'] as double?,
        deliveredByUs = json['DeliveredByUs'] as bool?,
        freeDeliveryFeesText = json['FreeDeliveryFeesText'],
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberofResult = json['TotalNumberofResult'] as int?;

  Map<String, dynamic> toJson() => {
    'IsOpen' : isOpen,
    'OpeningHours' : openingHours,
    'MostPopularImageUrl' : mostPopularImageUrl,
    'MostPopularText' : mostPopularText,
    'HasDailyDish' : hasDailyDish,
    'BrandId' : brandId,
    'BrandName' : brandName,
    'BrandImageUrl' : brandImageUrl,
    'BrandLogoUrl' : brandLogoUrl,
    'BrandDescription' : brandDescription,
    'BrandDiscount' : brandDiscount,
    'BrandMarketingText' : brandMarketingText,
    'BrandMinAmountToSpend' : brandMinAmountToSpend,
    'BrandMaxAmountToSpend' : brandMaxAmountToSpend,
    'BrandClassifications' : brandClassifications,
    'NumberOfOrderRate' : numberOfOrderRate,
    'BrandLabel' : brandLabel,
    'CategoryModel' : categoryModel?.map((e) => e.toJson()).toList(),
    'CanOrder' : canOrder,
    'BrandRateDetails' : brandRateDetails,
    'OrderRate' : orderRate,
    'DeliveredByUs' : deliveredByUs,
    'FreeDeliveryFeesText' : freeDeliveryFeesText,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors,
    'TotalNumberofResult' : totalNumberofResult
  };
}

