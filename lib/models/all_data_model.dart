
import 'package:Marouf/models/home_model.dart';
import 'package:Marouf/models/ordrer_details.dart';

import 'products_model.dart';

class AllDataModel {
  final BrandModel? brandModel;
  final RootCategories? categoryModel;
  final ProductItem? productItemModel;
  final bool? isSucceeded;
  final List<Errors>? errors;

  AllDataModel({
    this.brandModel,
    this.categoryModel,
    this.productItemModel,
    this.isSucceeded,
    this.errors,
  });

  AllDataModel.fromJson(Map<String, dynamic> json)
      : brandModel = (json['BrandModel'] as Map<String,dynamic>?) != null ? BrandModel.fromJson(json['BrandModel'] as Map<String,dynamic>) : null,
        categoryModel = (json['CategoryModel'] as Map<String,dynamic>?) != null ? RootCategories.fromJson(json['CategoryModel'] as Map<String,dynamic>) : null,
        productItemModel = (json['ProductItemModel'] as Map<String,dynamic>?) != null ? ProductItem.fromJson(json['ProductItemModel'] as Map<String,dynamic>) : null,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'BrandModel' : brandModel?.toJson(),
    'CategoryModel' : categoryModel?.toJson(),
    'ProductItemModel' : productItemModel?.toJson(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class BrandModel {
  final dynamic id;
  final String? name;
  final String? imageUrl;
  final String? openTime;
  final String? closeTime;
  final String? mostPopularImageUrl;
  final String? mostPopularText;
  final bool? hasDailyDish;
  final bool? isComingSoon;
  final dynamic orderDiscount;
  final String? description;
  final String? webSiteUrl;
  final String? faceBookUrl;
  final String? instagramUrl;
  final String? tiwtterUrl;
  final String? label;
  final bool? isBusy;
  final bool? isFreeDelivery;
  final String? busyReason;
  final List<ProductItem>? productItems;
  final dynamic productTotalNumberOfResult;
  final bool? deliveredByUs;
  final String? logoUrl;
  final bool? isFavorite;
  final dynamic orderRate;
  final List<BrandRateDetails>? brandRateDetails;
  final dynamic numberOfOrderRate;
  final String? marketingText;
  final String? classifications;
  final bool? supportScheduleOrder;
  final bool? isOpen;
  final String? openingHours;
  final String? orderingHours;
  final String? expectedDeliveryTime;
  final bool? canRecieveOrder;
  final bool? canOrderFromMerchant;
  final String? reasonForStoppingOrder;

  BrandModel({
    this.id,
    this.name,
    this.imageUrl,
    this.openTime,
    this.closeTime,
    this.mostPopularImageUrl,
    this.mostPopularText,
    this.hasDailyDish,
    this.isComingSoon,
    this.orderDiscount,
    this.description,
    this.webSiteUrl,
    this.faceBookUrl,
    this.instagramUrl,
    this.tiwtterUrl,
    this.label,
    this.isBusy,
    this.isFreeDelivery,
    this.busyReason,
    this.productItems,
    this.productTotalNumberOfResult,
    this.deliveredByUs,
    this.logoUrl,
    this.isFavorite,
    this.orderRate,
    this.brandRateDetails,
    this.numberOfOrderRate,
    this.marketingText,
    this.classifications,
    this.supportScheduleOrder,
    this.isOpen,
    this.openingHours,
    this.orderingHours,
    this.expectedDeliveryTime,
    this.canRecieveOrder,
    this.canOrderFromMerchant,
    this.reasonForStoppingOrder,
  });

  BrandModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        name = json['Name'] as String?,
        imageUrl = json['ImageUrl'] as String?,
        openTime = json['OpenTime'] as String?,
        closeTime = json['CloseTime'] as String?,
        mostPopularImageUrl = json['MostPopularImageUrl'] as String?,
        mostPopularText = json['MostPopularText'] as String?,
        hasDailyDish = json['HasDailyDish'] as bool?,
        isComingSoon = json['IsComingSoon'] as bool?,
        orderDiscount = json['OrderDiscount'] as dynamic,
        description = json['Description'] as String?,
        webSiteUrl = json['WebSiteUrl'] as String?,
        faceBookUrl = json['FaceBookUrl'] as String?,
        instagramUrl = json['InstagramUrl'] as String?,
        tiwtterUrl = json['TiwtterUrl'] as String?,
        label = json['Label'] as String?,
        isBusy = json['IsBusy'] as bool?,
        isFreeDelivery = json['IsFreeDelivery'] as bool?,
        busyReason = json['BusyReason'] as String?,
        productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList(),
        productTotalNumberOfResult = json['ProductTotalNumberOfResult'] as dynamic,
        deliveredByUs = json['DeliveredByUs'] as bool?,
        logoUrl = json['LogoUrl'] as String?,
        isFavorite = json['IsFavorite'] as bool?,
        orderRate = json['OrderRate'] as dynamic,
        brandRateDetails = (json['BrandRateDetails'] as List?)?.map((dynamic e) => BrandRateDetails.fromJson(e as Map<String,dynamic>)).toList(),
        numberOfOrderRate = json['NumberOfOrderRate'] as dynamic,
        marketingText = json['MarketingText'] as String?,
        classifications = json['Classifications'] as String?,
        supportScheduleOrder = json['SupportScheduleOrder'] as bool?,
        isOpen = json['IsOpen'] as bool?,
        openingHours = json['OpeningHours'] as String?,
        orderingHours = json['OrderingHours'] as String?,
        expectedDeliveryTime = json['ExpectedDeliveryTime'] as String?,
        canRecieveOrder = json['CanRecieveOrder'] as bool?,
        canOrderFromMerchant = json['CanOrderFromMerchant'] as bool?,
        reasonForStoppingOrder = json['ReasonForStoppingOrder'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'ImageUrl' : imageUrl,
    'OpenTime' : openTime,
    'CloseTime' : closeTime,
    'MostPopularImageUrl' : mostPopularImageUrl,
    'MostPopularText' : mostPopularText,
    'HasDailyDish' : hasDailyDish,
    'IsComingSoon' : isComingSoon,
    'OrderDiscount' : orderDiscount,
    'Description' : description,
    'WebSiteUrl' : webSiteUrl,
    'FaceBookUrl' : faceBookUrl,
    'InstagramUrl' : instagramUrl,
    'TiwtterUrl' : tiwtterUrl,
    'Label' : label,
    'IsBusy' : isBusy,
    'IsFreeDelivery' : isFreeDelivery,
    'BusyReason' : busyReason,
    'ProductItems' : productItems?.map((e) => e.toJson()).toList(),
    'ProductTotalNumberOfResult' : productTotalNumberOfResult,
    'DeliveredByUs' : deliveredByUs,
    'LogoUrl' : logoUrl,
    'IsFavorite' : isFavorite,
    'OrderRate' : orderRate,
    'BrandRateDetails' : brandRateDetails?.map((e) => e.toJson()).toList(),
    'NumberOfOrderRate' : numberOfOrderRate,
    'MarketingText' : marketingText,
    'Classifications' : classifications,
    'SupportScheduleOrder' : supportScheduleOrder,
    'IsOpen' : isOpen,
    'OpeningHours' : openingHours,
    'OrderingHours' : orderingHours,
    'ExpectedDeliveryTime' : expectedDeliveryTime,
    'CanRecieveOrder' : canRecieveOrder,
    'CanOrderFromMerchant' : canOrderFromMerchant,
    'ReasonForStoppingOrder' : reasonForStoppingOrder
  };
}


class BrandRateDetails {
  final dynamic rateValue;
  final dynamic numberOfOrderRated;

  BrandRateDetails({
    this.rateValue,
    this.numberOfOrderRated,
  });

  BrandRateDetails.fromJson(Map<String, dynamic> json)
      : rateValue = json['RateValue'] as dynamic,
        numberOfOrderRated = json['NumberOfOrderRated'] as dynamic;

  Map<String, dynamic> toJson() => {
    'RateValue' : rateValue,
    'NumberOfOrderRated' : numberOfOrderRated
  };
}