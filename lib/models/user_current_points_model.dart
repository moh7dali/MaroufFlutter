class UserCurrentPoints {
  dynamic balance;
  dynamic purchaseAmount;
  dynamic numberOfVisits;
  dynamic redeemedPoints;
  dynamic expiredPoints;
  RedeemConvertionData? redeemConvertionData;
  AddConvertionData? addConvertionData;
  String? currencyDisplayName;
  dynamic numberOfOrders;
  dynamic currentTier;
  TierData? tierData;
  List<TierDefinitions>? tierDefinitions;
  String? creationDate;
  String? fullName;
  bool? isSucceeded;
  List<Errors>? errors;

  UserCurrentPoints({
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
    this.isSucceeded,
    this.errors,
  });

  UserCurrentPoints.fromJson(Map<String, dynamic> json) {
    balance = json['Balance'] as dynamic;
    purchaseAmount = json['PurchaseAmount'] as dynamic;
    numberOfVisits = json['NumberOfVisits'] as dynamic;
    redeemedPoints = json['RedeemedPoints'] as dynamic;
    expiredPoints = json['ExpiredPoints'] as dynamic;
    redeemConvertionData = (json['RedeemConvertionData'] as Map<String,dynamic>?) != null ? RedeemConvertionData.fromJson(json['RedeemConvertionData'] as Map<String,dynamic>) : null;
    addConvertionData = (json['AddConvertionData'] as Map<String,dynamic>?) != null ? AddConvertionData.fromJson(json['AddConvertionData'] as Map<String,dynamic>) : null;
    currencyDisplayName = json['CurrencyDisplayName'] as String?;
    numberOfOrders = json['NumberOfOrders'] as dynamic;
    currentTier = json['CurrentTier'] as dynamic;
    tierData = (json['TierData'] as Map<String,dynamic>?) != null ? TierData.fromJson(json['TierData'] as Map<String,dynamic>) : null;
    tierDefinitions = (json['TierDefinitions'] as List?)?.map((dynamic e) => TierDefinitions.fromJson(e as Map<String,dynamic>)).toList();
    creationDate = json['CreationDate'] as String?;
    fullName = json['FullName'] as String?;
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Balance'] = balance;
    json['PurchaseAmount'] = purchaseAmount;
    json['NumberOfVisits'] = numberOfVisits;
    json['RedeemedPoints'] = redeemedPoints;
    json['ExpiredPoints'] = expiredPoints;
    json['RedeemConvertionData'] = redeemConvertionData?.toJson();
    json['AddConvertionData'] = addConvertionData?.toJson();
    json['CurrencyDisplayName'] = currencyDisplayName;
    json['NumberOfOrders'] = numberOfOrders;
    json['CurrentTier'] = currentTier;
    json['TierData'] = tierData?.toJson();
    json['TierDefinitions'] = tierDefinitions?.map((e) => e.toJson()).toList();
    json['CreationDate'] = creationDate;
    json['FullName'] = fullName;
    json['IsSucceeded'] = isSucceeded;
    json['Errors'] = errors?.map((e) => e.toJson()).toList();
    return json;
  }
}

class RedeemConvertionData {
  dynamic numberOfPoints;
  dynamic equivalentCashAmountPerUnit;

  RedeemConvertionData({
    this.numberOfPoints,
    this.equivalentCashAmountPerUnit,
  });

  RedeemConvertionData.fromJson(Map<String, dynamic> json) {
    numberOfPoints = json['NumberOfPoints'] as dynamic;
    equivalentCashAmountPerUnit = json['EquivalentCashAmountPerUnit'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['NumberOfPoints'] = numberOfPoints;
    json['EquivalentCashAmountPerUnit'] = equivalentCashAmountPerUnit;
    return json;
  }
}

class AddConvertionData {
  dynamic numberOfPoints;
  dynamic equivalentCashAmountPerUnit;

  AddConvertionData({
    this.numberOfPoints,
    this.equivalentCashAmountPerUnit,
  });

  AddConvertionData.fromJson(Map<String, dynamic> json) {
    numberOfPoints = json['NumberOfPoints'] as dynamic;
    equivalentCashAmountPerUnit = json['EquivalentCashAmountPerUnit'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['NumberOfPoints'] = numberOfPoints;
    json['EquivalentCashAmountPerUnit'] = equivalentCashAmountPerUnit;
    return json;
  }
}

class TierData {
  dynamic purchaseAmount;
  dynamic upperTierAmount;
  String? tierName;
  String? tierExpiryDate;
  dynamic tierDiscount;
  dynamic tierPercent;

  TierData({
    this.purchaseAmount,
    this.upperTierAmount,
    this.tierName,
    this.tierExpiryDate,
    this.tierDiscount,
    this.tierPercent,
  });

  TierData.fromJson(Map<String, dynamic> json) {
    purchaseAmount = json['PurchaseAmount'] as dynamic;
    upperTierAmount = json['UpperTierAmount'] as dynamic;
    tierName = json['TierName'] as String?;
    tierExpiryDate = json['TierExpiryDate'] as String?;
    tierDiscount = json['TierDiscount'] as dynamic;
    tierPercent = json['TierPercent'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['PurchaseAmount'] = purchaseAmount;
    json['UpperTierAmount'] = upperTierAmount;
    json['TierName'] = tierName;
    json['TierExpiryDate'] = tierExpiryDate;
    json['TierDiscount'] = tierDiscount;
    json['TierPercent'] = tierPercent;
    return json;
  }
}

class TierDefinitions {
  dynamic id;
  dynamic lowerLimit;
  String? name;
  dynamic discount;
  dynamic percent;

  TierDefinitions({
    this.id,
    this.lowerLimit,
    this.name,
    this.discount,
    this.percent,
  });

  TierDefinitions.fromJson(Map<String, dynamic> json) {
    id = json['Id'] as dynamic;
    lowerLimit = json['LowerLimit'] as dynamic;
    name = json['Name'] as String?;
    discount = json['Discount'] as dynamic;
    percent = json['Percent'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Id'] = id;
    json['LowerLimit'] = lowerLimit;
    json['Name'] = name;
    json['Discount'] = discount;
    json['Percent'] = percent;
    return json;
  }
}

class Errors {
  dynamic errorCode;
  String? errorMessage;

  Errors({
    this.errorCode,
    this.errorMessage,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'] as dynamic;
    errorMessage = json['ErrorMessage'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ErrorCode'] = errorCode;
    json['ErrorMessage'] = errorMessage;
    return json;
  }
}