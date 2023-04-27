import 'package:Marouf/models/ordrer_details.dart';

class ReOrderModel {
  final List<OrderItem>? data;
  final bool? isSucceeded;
  final List<Errors>? errors;

  ReOrderModel({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  ReOrderModel.fromJson(Map<String, dynamic> json)
      : data = (json['Data'] as List?)?.map((dynamic e) => OrderItem.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Data' : data?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class OrderItem {
  final dynamic id;
  final String? name;
  final String? url;
  final String? imageUrl;
  final dynamic price;
  final dynamic offerPrice;
  final dynamic priceId;
  final String? label;
  final String? currencyAbbreviation;
  final String? priceName;
  final dynamic brandId;
  final dynamic brandDiscount;
  final dynamic categoryId;
  final String? brandName;
  final String? instructions;
  final dynamic pricingTypes;
  final double? weight;
  final bool? isBlocked;
  final dynamic weightUnitId;
  final dynamic quantity;
  final bool? hasOptions;
  final dynamic itemTotalPrice;
  final dynamic noneOfferTotalPrice;
  final List<ReorderOptionItems>? reorderOptionItems;
  final List<ProductProperties>? productProperties;
  final String? brandImageUrl;
  final String? toDateLimit;
  final dynamic limitationTypeId;
  final dynamic stockQuantity;
  final bool? excludedFromDiscount;
  final dynamic preOrderPeriod;

  OrderItem({
    this.id,
    this.name,
    this.url,
    this.imageUrl,
    this.price,
    this.offerPrice,
    this.priceId,
    this.label,
    this.currencyAbbreviation,
    this.priceName,
    this.brandId,
    this.brandDiscount,
    this.categoryId,
    this.brandName,
    this.instructions,
    this.pricingTypes,
    this.weight,
    this.isBlocked,
    this.weightUnitId,
    this.quantity,
    this.hasOptions,
    this.itemTotalPrice,
    this.noneOfferTotalPrice,
    this.reorderOptionItems,
    this.productProperties,
    this.brandImageUrl,
    this.toDateLimit,
    this.limitationTypeId,
    this.stockQuantity,
    this.excludedFromDiscount,
    this.preOrderPeriod,
  });

  OrderItem.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        name = json['Name'] as String?,
        url = json['Url'] as String?,
        imageUrl = json['ImageUrl'] as String?,
        price = json['Price'] as dynamic,
        offerPrice = json['OfferPrice'] as dynamic,
        priceId = json['PriceId'] as dynamic,
        label = json['Label'] as String?,
        currencyAbbreviation = json['CurrencyAbbreviation'] as String?,
        priceName = json['PriceName'] as String?,
        brandId = json['BrandId'] as dynamic,
        brandDiscount = json['BrandDiscount'] as dynamic,
        categoryId = json['CategoryId'] as dynamic,
        brandName = json['BrandName'] as String?,
        instructions = json['Instructions'] as String?,
        pricingTypes = json['PricingTypes'] as dynamic,
        weight = json['Weight'] as double?,
        isBlocked = json['IsBlocked'] as bool?,
        weightUnitId = json['WeightUnitId'] as dynamic,
        quantity = json['Quantity'] as dynamic,
        hasOptions = json['HasOptions'] as bool?,
        itemTotalPrice = json['ItemTotalPrice'] as dynamic,
        noneOfferTotalPrice = json['NoneOfferTotalPrice'] as dynamic,
        reorderOptionItems = (json['ReorderOptionItems'] as List?)?.map((dynamic e) => ReorderOptionItems.fromJson(e as Map<String,dynamic>)).toList(),
        productProperties = (json['ProductProperties'] as List?)?.map((dynamic e) => ProductProperties.fromJson(e as Map<String,dynamic>)).toList(),
        brandImageUrl = json['BrandImageUrl'] as String?,
        toDateLimit = json['ToDateLimit'] as String?,
        limitationTypeId = json['LimitationTypeId'] as dynamic,
        stockQuantity = json['StockQuantity'] as dynamic,
        excludedFromDiscount = json['ExcludedFromDiscount'] as bool?,
        preOrderPeriod = json['PreOrderPeriod'] as dynamic;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Url' : url,
    'ImageUrl' : imageUrl,
    'Price' : price,
    'OfferPrice' : offerPrice,
    'PriceId' : priceId,
    'Label' : label,
    'CurrencyAbbreviation' : currencyAbbreviation,
    'PriceName' : priceName,
    'BrandId' : brandId,
    'BrandDiscount' : brandDiscount,
    'CategoryId' : categoryId,
    'BrandName' : brandName,
    'Instructions' : instructions,
    'PricingTypes' : pricingTypes,
    'Weight' : weight,
    'IsBlocked' : isBlocked,
    'WeightUnitId' : weightUnitId,
    'Quantity' : quantity,
    'HasOptions' : hasOptions,
    'ItemTotalPrice' : itemTotalPrice,
    'NoneOfferTotalPrice' : noneOfferTotalPrice,
    'ReorderOptionItems' : reorderOptionItems?.map((e) => e.toJson()).toList(),
    'ProductProperties' : productProperties?.map((e) => e.toJson()).toList(),
    'BrandImageUrl' : brandImageUrl,
    'ToDateLimit' : toDateLimit,
    'LimitationTypeId' : limitationTypeId,
    'StockQuantity' : stockQuantity,
    'ExcludedFromDiscount' : excludedFromDiscount,
    'PreOrderPeriod' : preOrderPeriod
  };
}

class ReorderOptionItems {
  final dynamic id;
  final String? name;
  final dynamic quantity;
  final dynamic itemTotalPrice;
  final dynamic optionId;
  final String? optionName;

  ReorderOptionItems({
    this.id,
    this.name,
    this.quantity,
    this.itemTotalPrice,
    this.optionId,
    this.optionName,
  });

  ReorderOptionItems.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        name = json['Name'] as String?,
        quantity = json['Quantity'] as dynamic,
        itemTotalPrice = json['ItemTotalPrice'] as dynamic,
        optionId = json['OptionId'] as dynamic,
        optionName = json['OptionName'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Quantity' : quantity,
    'ItemTotalPrice' : itemTotalPrice,
    'OptionId' : optionId,
    'OptionName' : optionName
  };
}

class ProductProperties {
  final String? name;
  final String? value;
  final dynamic type;
  final String? imageUrl;
  final dynamic id;

  ProductProperties({
    this.name,
    this.value,
    this.type,
    this.imageUrl,
    this.id,
  });

  ProductProperties.fromJson(Map<String, dynamic> json)
      : name = json['Name'] as String?,
        value = json['Value'] as String?,
        type = json['Type'] as dynamic,
        imageUrl = json['ImageUrl'] as String?,
        id = json['Id'] as dynamic;

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Value' : value,
    'Type' : type,
    'ImageUrl' : imageUrl,
    'Id' : id
  };
}
