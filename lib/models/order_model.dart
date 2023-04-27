import 'package:Marouf/models/main_response.dart';

class OrderModel {
  final String? paymentToken;
  final List<UnavailableItems>? unavailableItems;
  final List<UnavailableOptionItems>? unavailableOptionItems;
  final List<OutOfStockItem>? outOfStockItem;
  final List<CustomerPaymentCardInfos>? customerPaymentCardInfos;
  final OrderPossibilityResult? orderPossibilityResult;
  final String? customerEmail;
  final dynamic orderId;
  final dynamic totalOrderAmount;
  final String? webPaymentUrl;
  final String? socialEventName;
  final bool? isSucceeded;
  final List<Error>? errors;

  OrderModel({
    this.paymentToken,
    this.unavailableItems,
    this.unavailableOptionItems,
    this.outOfStockItem,
    this.customerPaymentCardInfos,
    this.orderPossibilityResult,
    this.customerEmail,
    this.orderId,
    this.totalOrderAmount,
    this.webPaymentUrl,
    this.socialEventName,
    this.isSucceeded,
    this.errors,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : paymentToken = json['PaymentToken'] as String?,
        unavailableItems = (json['UnavailableItems'] as List?)?.map((dynamic e) => UnavailableItems.fromJson(e as Map<String,dynamic>)).toList(),
        unavailableOptionItems = (json['UnavailableOptionItems'] as List?)?.map((dynamic e) => UnavailableOptionItems.fromJson(e as Map<String,dynamic>)).toList(),
        outOfStockItem = (json['OutOfStockItem'] as List?)?.map((dynamic e) => OutOfStockItem.fromJson(e as Map<String,dynamic>)).toList(),
        customerPaymentCardInfos = (json['CustomerPaymentCardInfos'] as List?)?.map((dynamic e) => CustomerPaymentCardInfos.fromJson(e as Map<String,dynamic>)).toList(),
        orderPossibilityResult = (json['OrderPossibilityResult'] as Map<String,dynamic>?) != null ? OrderPossibilityResult.fromJson(json['OrderPossibilityResult'] as Map<String,dynamic>) : null,
        customerEmail = json['CustomerEmail'] as String?,
        orderId = json['OrderId'] as dynamic,
        totalOrderAmount = json['TotalOrderAmount'] as dynamic,
        webPaymentUrl = json['WebPaymentUrl'] as String?,
        socialEventName = json['SocialEventName'] as String?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'PaymentToken' : paymentToken,
    'UnavailableItems' : unavailableItems?.map((e) => e.toJson()).toList(),
    'UnavailableOptionItems' : unavailableOptionItems?.map((e) => e.toJson()).toList(),
    'OutOfStockItem' : outOfStockItem?.map((e) => e.toJson()).toList(),
    'CustomerPaymentCardInfos' : customerPaymentCardInfos?.map((e) => e.toJson()).toList(),
    'OrderPossibilityResult' : orderPossibilityResult?.toJson(),
    'CustomerEmail' : customerEmail,
    'OrderId' : orderId,
    'TotalOrderAmount' : totalOrderAmount,
    'WebPaymentUrl' : webPaymentUrl,
    'SocialEventName' : socialEventName,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class UnavailableItems {
  final dynamic id;
  final String? productName;
  final String? displayStartTime;
  final String? displayEndTime;

  UnavailableItems({
    this.id,
    this.productName,
    this.displayStartTime,
    this.displayEndTime,
  });

  UnavailableItems.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        productName = json['ProductName'] as String?,
        displayStartTime = json['DisplayStartTime'] as String?,
        displayEndTime = json['DisplayEndTime'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'ProductName' : productName,
    'DisplayStartTime' : displayStartTime,
    'DisplayEndTime' : displayEndTime
  };
}

class UnavailableOptionItems {
  final dynamic productId;
  final String? productName;
  final dynamic optionOptionItemId;
  final String? optionItemName;

  UnavailableOptionItems({
    this.productId,
    this.productName,
    this.optionOptionItemId,
    this.optionItemName,
  });

  UnavailableOptionItems.fromJson(Map<String, dynamic> json)
      : productId = json['ProductId'] as dynamic,
        productName = json['ProductName'] as String?,
        optionOptionItemId = json['OptionOptionItemId'] as dynamic,
        optionItemName = json['OptionItemName'] as String?;

  Map<String, dynamic> toJson() => {
    'ProductId' : productId,
    'ProductName' : productName,
    'OptionOptionItemId' : optionOptionItemId,
    'OptionItemName' : optionItemName
  };
}

class OutOfStockItem {
  final dynamic id;
  final String? productName;

  OutOfStockItem({
    this.id,
    this.productName,
  });

  OutOfStockItem.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        productName = json['ProductName'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'ProductName' : productName
  };
}

class CustomerPaymentCardInfos {
  final String? cardNumber;
  final String? cardReferenceId;
  final String? imageUrl;

  CustomerPaymentCardInfos({
    this.cardNumber,
    this.cardReferenceId,
    this.imageUrl,
  });

  CustomerPaymentCardInfos.fromJson(Map<String, dynamic> json)
      : cardNumber = json['CardNumber'] as String?,
        cardReferenceId = json['CardReferenceId'] as String?,
        imageUrl = json['ImageUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'CardNumber' : cardNumber,
    'CardReferenceId' : cardReferenceId,
    'ImageUrl' : imageUrl
  };
}

class OrderPossibilityResult {
  final bool? canOrder;
  final bool? isBusyBrand;
  final bool? canOrderFromMerchant;
  final String? reasonForStoppingOrder;
  final String? fromDate;
  final String? toDate;
  final bool? canDeliver;
  final String? deliveryFromDate;
  final String? deliveryToDate;
  final bool? supportBrandPreOrderOnly;
  final String? preOrderPeriod;
  final bool? branchNotAvailable;
  final bool? branchPickupNotAvailable;

  OrderPossibilityResult({
    this.canOrder,
    this.isBusyBrand,
    this.canOrderFromMerchant,
    this.reasonForStoppingOrder,
    this.fromDate,
    this.toDate,
    this.canDeliver,
    this.deliveryFromDate,
    this.deliveryToDate,
    this.supportBrandPreOrderOnly,
    this.preOrderPeriod,
    this.branchNotAvailable,
    this.branchPickupNotAvailable,
  });

  OrderPossibilityResult.fromJson(Map<String, dynamic> json)
      : canOrder = json['CanOrder'] as bool?,
        isBusyBrand = json['IsBusyBrand'] as bool?,
        canOrderFromMerchant = json['CanOrderFromMerchant'] as bool?,
        reasonForStoppingOrder = json['ReasonForStoppingOrder'] as String?,
        fromDate = json['FromDate'] as String?,
        toDate = json['ToDate'] as String?,
        canDeliver = json['CanDeliver'] as bool?,
        deliveryFromDate = json['DeliveryFromDate'] as String?,
        deliveryToDate = json['DeliveryToDate'] as String?,
        supportBrandPreOrderOnly = json['SupportBrandPreOrderOnly'] as bool?,
        preOrderPeriod = json['PreOrderPeriod'] as String?,
        branchNotAvailable = json['BranchNotAvailable'] as bool?,
        branchPickupNotAvailable = json['BranchPickupNotAvailable'] as bool?;

  Map<String, dynamic> toJson() => {
    'CanOrder' : canOrder,
    'IsBusyBrand' : isBusyBrand,
    'CanOrderFromMerchant' : canOrderFromMerchant,
    'ReasonForStoppingOrder' : reasonForStoppingOrder,
    'FromDate' : fromDate,
    'ToDate' : toDate,
    'CanDeliver' : canDeliver,
    'DeliveryFromDate' : deliveryFromDate,
    'DeliveryToDate' : deliveryToDate,
    'SupportBrandPreOrderOnly' : supportBrandPreOrderOnly,
    'PreOrderPeriod' : preOrderPeriod,
    'BranchNotAvailable' : branchNotAvailable,
    'BranchPickupNotAvailable' : branchPickupNotAvailable
  };
}
