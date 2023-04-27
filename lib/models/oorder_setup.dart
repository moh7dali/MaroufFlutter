import 'package:Marouf/models/main_response.dart';

class OrderSetup {
  final dynamic tax;
  final dynamic includedTaxValue;
  final dynamic deliveryFees;
  final int? orderPreparationFromDuration;
  final int? orderPreparationToDuration;
  final dynamic orderTotalPriceLimitation;
  final bool? enableDeliveryMethod;
  final int? minimumPeriodToOrder;
  final dynamic userBalance;
  final List<DeliveryFeesPrices>? deliveryFeesPrices;
  final DeliveryRuleModel? deliveryRuleModel;
  final bool? hasLoyaltyCard;
  final bool? supportPreOrderOnly;
  final bool? canOrderFromMerchant;
  final bool? isBrandBusy;
  final String? reasonForStoppingOrder;
  final dynamic closestBranchId;
  final List<AvailablePaymentTypes>? availablePaymentTypes;
  final dynamic discount;
  final dynamic minAmountToSpend;
  final dynamic maxAmountToSpend;
  final int? orderDeliveryFromDuration;
  final int? orderDeliveryToDuration;
  final List<DeliveryFeesDiscounts>? deliveryFeesDiscounts;
  final List<UserRewards>? userRewards;
  final List<SupportPickupBranches>? supportPickupBranches;
  final bool? supportPickup;
  final bool? supportScheduleOrder;
  final dynamic redeemLimitationPercentage;
  final dynamic minimumBalanceToRedeem;
  final bool? isSucceeded;
  final List<Error>? errors;

  OrderSetup({
    this.tax,
    this.includedTaxValue,
    this.deliveryFees,
    this.orderPreparationFromDuration,
    this.orderPreparationToDuration,
    this.orderTotalPriceLimitation,
    this.enableDeliveryMethod,
    this.minimumPeriodToOrder,
    this.userBalance,
    this.deliveryFeesPrices,
    this.deliveryRuleModel,
    this.hasLoyaltyCard,
    this.supportPreOrderOnly,
    this.canOrderFromMerchant,
    this.isBrandBusy,
    this.reasonForStoppingOrder,
    this.closestBranchId,
    this.availablePaymentTypes,
    this.discount,
    this.minAmountToSpend,
    this.maxAmountToSpend,
    this.orderDeliveryFromDuration,
    this.orderDeliveryToDuration,
    this.deliveryFeesDiscounts,
    this.userRewards,
    this.supportPickupBranches,
    this.supportPickup,
    this.supportScheduleOrder,
    this.redeemLimitationPercentage,
    this.minimumBalanceToRedeem,
    this.isSucceeded,
    this.errors,
  });

  OrderSetup.fromJson(Map<String, dynamic> json)
      : tax = json['Tax'] ,
        includedTaxValue = json['IncludedTaxValue'] ,
        deliveryFees = json['DeliveryFees'] ,
        orderPreparationFromDuration = json['OrderPreparationFromDuration'] ,
        orderPreparationToDuration = json['OrderPreparationToDuration'] ,
        orderTotalPriceLimitation = json['OrderTotalPriceLimitation'] ,
        enableDeliveryMethod = json['EnableDeliveryMethod'] as bool?,
        minimumPeriodToOrder = json['MinimumPeriodToOrder'] ,
        userBalance = json['UserBalance'] ,
        deliveryFeesPrices = (json['DeliveryFeesPrices'] as List?)?.map((dynamic e) => DeliveryFeesPrices.fromJson(e as Map<String,dynamic>)).toList(),
        deliveryRuleModel = (json['DeliveryRuleModel'] as Map<String,dynamic>?) != null ? DeliveryRuleModel.fromJson(json['DeliveryRuleModel'] as Map<String,dynamic>) : null,
        hasLoyaltyCard = json['HasLoyaltyCard'] as bool?,
        supportPreOrderOnly = json['SupportPreOrderOnly'] as bool?,
        canOrderFromMerchant = json['CanOrderFromMerchant'] as bool?,
        isBrandBusy = json['IsBrandBusy'] as bool?,
        reasonForStoppingOrder = json['ReasonForStoppingOrder'] as String?,
        closestBranchId = json['ClosestBranchId'] ,
        availablePaymentTypes = (json['AvailablePaymentTypes'] as List?)?.map((dynamic e) => AvailablePaymentTypes.fromJson(e as Map<String,dynamic>)).toList(),
        discount = json['Discount'] ,
        minAmountToSpend = json['MinAmountToSpend'] ,
        maxAmountToSpend = json['MaxAmountToSpend'] ,
        orderDeliveryFromDuration = json['OrderDeliveryFromDuration'] ,
        orderDeliveryToDuration = json['OrderDeliveryToDuration'] ,
        deliveryFeesDiscounts = (json['DeliveryFeesDiscounts'] as List?)?.map((dynamic e) => DeliveryFeesDiscounts.fromJson(e as Map<String,dynamic>)).toList(),
        userRewards = (json['UserRewards'] as List?)?.map((dynamic e) => UserRewards.fromJson(e as Map<String,dynamic>)).toList(),
        supportPickupBranches = (json['SupportPickupBranches'] as List?)?.map((dynamic e) => SupportPickupBranches.fromJson(e as Map<String,dynamic>)).toList(),
        supportPickup = json['SupportPickup'] as bool?,
        supportScheduleOrder = json['SupportScheduleOrder'] as bool?,
        redeemLimitationPercentage = json['RedeemLimitationPercentage'] ,
        minimumBalanceToRedeem = json['MinimumBalanceToRedeem'] ,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Tax' : tax,
    'IncludedTaxValue' : includedTaxValue,
    'DeliveryFees' : deliveryFees,
    'OrderPreparationFromDuration' : orderPreparationFromDuration,
    'OrderPreparationToDuration' : orderPreparationToDuration,
    'OrderTotalPriceLimitation' : orderTotalPriceLimitation,
    'EnableDeliveryMethod' : enableDeliveryMethod,
    'MinimumPeriodToOrder' : minimumPeriodToOrder,
    'UserBalance' : userBalance,
    'DeliveryFeesPrices' : deliveryFeesPrices?.map((e) => e.toJson()).toList(),
    'DeliveryRuleModel' : deliveryRuleModel?.toJson(),
    'HasLoyaltyCard' : hasLoyaltyCard,
    'SupportPreOrderOnly' : supportPreOrderOnly,
    'CanOrderFromMerchant' : canOrderFromMerchant,
    'IsBrandBusy' : isBrandBusy,
    'ReasonForStoppingOrder' : reasonForStoppingOrder,
    'ClosestBranchId' : closestBranchId,
    'AvailablePaymentTypes' : availablePaymentTypes?.map((e) => e.toJson()).toList(),
    'Discount' : discount,
    'MinAmountToSpend' : minAmountToSpend,
    'MaxAmountToSpend' : maxAmountToSpend,
    'OrderDeliveryFromDuration' : orderDeliveryFromDuration,
    'OrderDeliveryToDuration' : orderDeliveryToDuration,
    'DeliveryFeesDiscounts' : deliveryFeesDiscounts?.map((e) => e.toJson()).toList(),
    'UserRewards' : userRewards?.map((e) => e.toJson()).toList(),
    'SupportPickupBranches' : supportPickupBranches?.map((e) => e.toJson()).toList(),
    'SupportPickup' : supportPickup,
    'SupportScheduleOrder' : supportScheduleOrder,
    'RedeemLimitationPercentage' : redeemLimitationPercentage,
    'MinimumBalanceToRedeem' : minimumBalanceToRedeem,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class DeliveryFeesPrices {
  final dynamic fromValue;
  final dynamic toValue;
  final dynamic price;
  final dynamic offerPrice;
  final int? deliveryType;

  DeliveryFeesPrices({
    this.fromValue,
    this.toValue,
    this.price,
    this.offerPrice,
    this.deliveryType,
  });

  DeliveryFeesPrices.fromJson(Map<String, dynamic> json)
      : fromValue = json['FromValue'] ,
        toValue = json['ToValue'] ,
        price = json['Price'] ,
        offerPrice = json['OfferPrice'] ,
        deliveryType = json['DeliveryType'] ;

  Map<String, dynamic> toJson() => {
    'FromValue' : fromValue,
    'ToValue' : toValue,
    'Price' : price,
    'OfferPrice' : offerPrice,
    'DeliveryType' : deliveryType
  };
}

class DeliveryRuleModel {
  final int? minimumDayToOrder;
  final int? maximumDayToOrder;
  final List<DeliveryRuleDefinitionsModel>? deliveryRuleDefinitionsModel;

  DeliveryRuleModel({
    this.minimumDayToOrder,
    this.maximumDayToOrder,
    this.deliveryRuleDefinitionsModel,
  });

  DeliveryRuleModel.fromJson(Map<String, dynamic> json)
      : minimumDayToOrder = json['MinimumDayToOrder'] ,
        maximumDayToOrder = json['MaximumDayToOrder'] ,
        deliveryRuleDefinitionsModel = (json['DeliveryRuleDefinitionsModel'] as List?)?.map((dynamic e) => DeliveryRuleDefinitionsModel.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'MinimumDayToOrder' : minimumDayToOrder,
    'MaximumDayToOrder' : maximumDayToOrder,
    'DeliveryRuleDefinitionsModel' : deliveryRuleDefinitionsModel?.map((e) => e.toJson()).toList()
  };
}

class DeliveryRuleDefinitionsModel {
  final int? dayId;
  final bool? canOrder;
  final bool? canOrderNow;
  final bool? canDeliver;
  final String? orderFromTime;
  final String? orderToTime;
  final String? deliveryFromTime;
  final String? deliveryToTime;

  DeliveryRuleDefinitionsModel({
    this.dayId,
    this.canOrder,
    this.canOrderNow,
    this.canDeliver,
    this.orderFromTime,
    this.orderToTime,
    this.deliveryFromTime,
    this.deliveryToTime,
  });

  DeliveryRuleDefinitionsModel.fromJson(Map<String, dynamic> json)
      : dayId = json['DayId'] ,
        canOrder = json['CanOrder'] as bool?,
        canOrderNow = json['CanOrderNow'] as bool?,
        canDeliver = json['CanDeliver'] as bool?,
        orderFromTime = json['OrderFromTime'] as String?,
        orderToTime = json['OrderToTime'] as String?,
        deliveryFromTime = json['DeliveryFromTime'] as String?,
        deliveryToTime = json['DeliveryToTime'] as String?;

  Map<String, dynamic> toJson() => {
    'DayId' : dayId,
    'CanOrder' : canOrder,
    'CanOrderNow' : canOrderNow,
    'CanDeliver' : canDeliver,
    'OrderFromTime' : orderFromTime,
    'OrderToTime' : orderToTime,
    'DeliveryFromTime' : deliveryFromTime,
    'DeliveryToTime' : deliveryToTime
  };
}

class AvailablePaymentTypes {
  final int? id;
  final String? name;

  AvailablePaymentTypes({
    this.id,
    this.name,
  });

  AvailablePaymentTypes.fromJson(Map<String, dynamic> json)
      : id = json['Id'] ,
        name = json['Name'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name
  };
}

class DeliveryFeesDiscounts {
  final dynamic id;
  final dynamic fromValue;
  final dynamic toValue;
  final dynamic discountTypeId;
  final dynamic discountValue;

  DeliveryFeesDiscounts({
    this.id,
    this.fromValue,
    this.toValue,
    this.discountTypeId,
    this.discountValue,
  });

  DeliveryFeesDiscounts.fromJson(Map<String, dynamic> json)
      : id = json['Id'] ,
        fromValue = json['FromValue'] ,
        toValue = json['ToValue'] ,
        discountTypeId = json['DiscountTypeId'] ,
        discountValue = json['DiscountValue'] ;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'FromValue' : fromValue,
    'ToValue' : toValue,
    'DiscountTypeId' : discountTypeId,
    'DiscountValue' : discountValue
  };
}

class UserRewards {
  final dynamic id;
  final dynamic rewardId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final dynamic rewardTypes;
  final dynamic rewardActionTypes;
  final bool? hasPurshaseAmountLimit;
  final dynamic purshaseAmountLimit;
  final dynamic productId;
  final String? productName;
  final dynamic discountValue;
  final dynamic discountTypes;
  final String? expiryDate;
  final dynamic maxAmountToSpend;

  UserRewards({
    this.id,
    this.rewardId,
    this.title,
    this.description,
    this.imageUrl,
    this.rewardTypes,
    this.rewardActionTypes,
    this.hasPurshaseAmountLimit,
    this.purshaseAmountLimit,
    this.productId,
    this.productName,
    this.discountValue,
    this.discountTypes,
    this.expiryDate,
    this.maxAmountToSpend,
  });

  UserRewards.fromJson(Map<String, dynamic> json)
      : id = json['Id'] ,
        rewardId = json['RewardId'] ,
        title = json['Title'] as String?,
        description = json['Description'] as String?,
        imageUrl = json['ImageUrl'] as String?,
        rewardTypes = json['RewardTypes'] ,
        rewardActionTypes = json['RewardActionTypes'] ,
        hasPurshaseAmountLimit = json['HasPurshaseAmountLimit'] as bool?,
        purshaseAmountLimit = json['PurshaseAmountLimit'] ,
        productId = json['ProductId'] ,
        productName = json['ProductName'] as String?,
        discountValue = json['DiscountValue'] ,
        discountTypes = json['DiscountTypes'] ,
        expiryDate = json['ExpiryDate'] as String?,
        maxAmountToSpend = json['MaxAmountToSpend'] ;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'RewardId' : rewardId,
    'Title' : title,
    'Description' : description,
    'ImageUrl' : imageUrl,
    'RewardTypes' : rewardTypes,
    'RewardActionTypes' : rewardActionTypes,
    'HasPurshaseAmountLimit' : hasPurshaseAmountLimit,
    'PurshaseAmountLimit' : purshaseAmountLimit,
    'ProductId' : productId,
    'ProductName' : productName,
    'DiscountValue' : discountValue,
    'DiscountTypes' : discountTypes,
    'ExpiryDate' : expiryDate,
    'MaxAmountToSpend' : maxAmountToSpend
  };
}

class SupportPickupBranches {
  final dynamic id;
  final String? name;

  SupportPickupBranches({
    this.id,
    this.name,
  });

  SupportPickupBranches.fromJson(Map<String, dynamic> json)
      : id = json['Id'] ,
        name = json['Name'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name
  };
}
