// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/models/order_history.dart';
import 'package:Marouf/models/products_model.dart';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    this.id,
    this.itemNumber,
    this.categoryId,
    this.name,
    this.label,
    this.description,
    this.hasOptions,
    this.orderTotalPriceLimitation,
    this.includedInTotalPriceLimitation,
    this.orderingHours,
    this.reasonForStoppingOrder,
    this.orderFromTime,
    this.orderToTime,
    this.canRecieveOrder,
    this.canOrderFromMerchant,
    this.isBusy,
    this.busyReason,
    this.openingHours,
    this.brandId,
    this.brandName,
    this.isOpen,
    this.pricingTypes,
    this.brandImageUrl,
    this.toDateLimit,
    this.limitationTypeId,
    this.stockQuantity,
    this.tax,
    this.referenceItemId,
    this.isMostPopular,
    this.url,
    this.productUrl,
    this.trademarkData,
    this.hasOnlineOrdering,
    this.productItemImageModel,
    this.relatedProductModel,
    this.productItemPriceModel,
    this.productItemOptions,
    this.productProperties,
    this.trademarkName,
    this.outOfStock,
    this.genderId,
    this.brandLogoUrl,
    this.isPreOrder,
    this.preOrderPeriod,
    this.excludedFromDiscount,
    this.numberOfCalories,
    this.supportScheduleOrder,
    this.isSucceeded,
    this.errors,
  });

  int? id;
  dynamic itemNumber;

  int? categoryId;
  String? name;
  dynamic label;
  dynamic description;
  bool? hasOptions;
  dynamic orderTotalPriceLimitation;
  bool? includedInTotalPriceLimitation;
  String? orderingHours;
  dynamic reasonForStoppingOrder;
  String? orderFromTime;
  String? orderToTime;
  bool? canRecieveOrder;
  bool? canOrderFromMerchant;
  bool? isBusy;
  dynamic busyReason;
  String? openingHours;
  int? brandId;
  String? brandName;
  bool? isOpen;
  int? pricingTypes;
  String? brandImageUrl;
  dynamic toDateLimit;
  dynamic limitationTypeId;
  dynamic stockQuantity;
  dynamic tax;
  dynamic referenceItemId;
  bool? isMostPopular;
  dynamic url;
  dynamic productUrl;
  bool? hasOnlineOrdering;
  List<ProductItemImageModel>? productItemImageModel;
  final List<ProductItem>? relatedProductModel;
  List<ProductItemPriceModel>? productItemPriceModel;
  List<ProductItemOption>? productItemOptions;
  final List<ProductProperties>? productProperties;
  dynamic trademarkName;
  bool? outOfStock;
  final TrademarkData? trademarkData;
  dynamic genderId;
  dynamic brandLogoUrl;
  bool? isPreOrder;
  dynamic preOrderPeriod;
  bool? excludedFromDiscount;
  dynamic numberOfCalories;
  bool? supportScheduleOrder;
  bool? isSucceeded;
  List<Error>? errors;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["Id"],
        itemNumber: json["ItemNumber"],
        categoryId: json["CategoryId"],
        name: json["Name"],
        label: json["Label"],
        description: json["Description"],
        relatedProductModel: (json['RelatedProductModel'] as List?)
            ?.map(
                (dynamic e) => ProductItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        hasOptions: json["HasOptions"],
        orderTotalPriceLimitation: json["OrderTotalPriceLimitation"],
        includedInTotalPriceLimitation: json["IncludedInTotalPriceLimitation"],
        orderingHours: json["OrderingHours"],
        reasonForStoppingOrder: json["ReasonForStoppingOrder"],
        orderFromTime: json["OrderFromTime"],
        orderToTime: json["OrderToTime"],
        canRecieveOrder: json["CanRecieveOrder"],
        canOrderFromMerchant: json["CanOrderFromMerchant"],
        isBusy: json["IsBusy"],
        busyReason: json["BusyReason"],
        openingHours: json["OpeningHours"],
        brandId: json["BrandId"],
        brandName: json["BrandName"],
        isOpen: json["IsOpen"],
        pricingTypes: json["PricingTypes"],
        brandImageUrl: json["BrandImageUrl"],
        toDateLimit: json["ToDateLimit"],
        limitationTypeId: json["LimitationTypeId"],
        stockQuantity: json["StockQuantity"],
        tax: json["Tax"],
        referenceItemId: json["ReferenceItemId"],
        isMostPopular: json["IsMostPopular"],
        url: json["Url"],
        productUrl: json["ProductUrl"],
        hasOnlineOrdering: json["HasOnlineOrdering"],
        productItemImageModel: json["ProductItemImageModel"] == null
            ? null
            : List<ProductItemImageModel>.from(json["ProductItemImageModel"]
                .map((x) => ProductItemImageModel.fromJson(x))),
        productItemPriceModel: json["ProductItemPriceModel"] == null
            ? null
            : List<ProductItemPriceModel>.from(json["ProductItemPriceModel"]
                .map((x) => ProductItemPriceModel.fromJson(x))),
        productItemOptions: json["ProductItemOptions"] == null
            ? null
            : List<ProductItemOption>.from(json["ProductItemOptions"]
                .map((x) => ProductItemOption.fromJson(x))),
        productProperties: (json['ProductProperties'] as List?)
            ?.map((dynamic e) =>
                ProductProperties.fromJson(e as Map<String, dynamic>))
            .toList(),
        trademarkName: json["TrademarkName"],
        outOfStock: json["OutOfStock"],
        trademarkData: (json['TrademarkData'] as Map<String, dynamic>?) != null
            ? TrademarkData.fromJson(
                json['TrademarkData'] as Map<String, dynamic>)
            : null,
        genderId: json["GenderId"],
        brandLogoUrl: json["BrandLogoUrl"],
        isPreOrder: json["IsPreOrder"],
        preOrderPeriod: json["PreOrderPeriod"],
        excludedFromDiscount: json["ExcludedFromDiscount"],
        numberOfCalories: json["NumberOfCalories"],
        supportScheduleOrder: json["SupportScheduleOrder"],
        isSucceeded: json["IsSucceeded"],
        errors: json["Errors"] == null
            ? null
            : List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ItemNumber": itemNumber,
        "CategoryId": categoryId,
        "Name": name,
        "Label": label,
        "Description": description,
        'TrademarkData': trademarkData?.toJson(),
        "HasOptions": hasOptions,
        "OrderTotalPriceLimitation": orderTotalPriceLimitation,
        "IncludedInTotalPriceLimitation": includedInTotalPriceLimitation,
        "OrderingHours": orderingHours,
        "ReasonForStoppingOrder": reasonForStoppingOrder,
        "OrderFromTime": orderFromTime,
        "OrderToTime": orderToTime,
        "CanRecieveOrder": canRecieveOrder,
        "CanOrderFromMerchant": canOrderFromMerchant,
        "IsBusy": isBusy,
        "BusyReason": busyReason,
        "OpeningHours": openingHours,
        "BrandId": brandId,
        "BrandName": brandName,
        "IsOpen": isOpen,
        "PricingTypes": pricingTypes,
        "BrandImageUrl": brandImageUrl,
        "ToDateLimit": toDateLimit,
        "LimitationTypeId": limitationTypeId,
        "StockQuantity": stockQuantity,
        "Tax": tax,
        "ReferenceItemId": referenceItemId,
        "IsMostPopular": isMostPopular,
        "Url": url,
        "ProductUrl": productUrl,
        "HasOnlineOrdering": hasOnlineOrdering,
        "ProductItemImageModel": productItemImageModel == null
            ? null
            : List<dynamic>.from(productItemImageModel!.map((x) => x.toJson())),
        'RelatedProductModel':
            relatedProductModel?.map((e) => e.toJson()).toList(),
        "ProductItemPriceModel": productItemPriceModel == null
            ? null
            : List<dynamic>.from(productItemPriceModel!.map((x) => x.toJson())),
        "ProductItemOptions": productItemOptions == null
            ? null
            : List<dynamic>.from(productItemOptions!.map((x) => x.toJson())),
        "ProductProperties": productProperties == null
            ? null
            : List<dynamic>.from(productProperties!.map((x) => x)),
        "TrademarkName": trademarkName,
        'ProductProperties': productProperties?.map((e) => e.toJson()).toList(),
        "OutOfStock": outOfStock,
        "GenderId": genderId,
        "BrandLogoUrl": brandLogoUrl,
        "IsPreOrder": isPreOrder,
        "PreOrderPeriod": preOrderPeriod,
        "ExcludedFromDiscount": excludedFromDiscount,
        "NumberOfCalories": numberOfCalories,
        "SupportScheduleOrder": supportScheduleOrder,
        "IsSucceeded": isSucceeded,
        "Errors": errors == null
            ? null
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class ProductItemImageModel {
  ProductItemImageModel({
    this.id,
    this.url,
  });

  int? id;
  String? url;

  factory ProductItemImageModel.fromJson(Map<String, dynamic> json) =>
      ProductItemImageModel(
        id: json["Id"],
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Url": url,
      };
}

class ProductItemOption {
  ProductItemOption({
    this.optionId,
    this.optionName,
    this.maximumNumberToSelect,
    this.optionLable,
    this.optionType,
    this.optionItems,
  });

  int? optionId;
  String? optionName;
  int? maximumNumberToSelect;
  String? optionLable;
  int? optionType;
  List<OptionItem>? optionItems;

  factory ProductItemOption.fromJson(Map<String, dynamic> json) =>
      ProductItemOption(
        optionId: json["OptionId"],
        optionName: json["OptionName"],
        maximumNumberToSelect: json["MaximumNumberToSelect"],
        optionLable: json["OptionLable"],
        optionType: json["OptionType"],
        optionItems: json["OptionItems"] == null
            ? null
            : List<OptionItem>.from(
                json["OptionItems"].map((x) => OptionItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "OptionId": optionId,
        "OptionName": optionName,
        "MaximumNumberToSelect": maximumNumberToSelect,
        "OptionLable": optionLable,
        "OptionType": optionType,
        "OptionItems": optionItems == null
            ? null
            : List<dynamic>.from(optionItems!.map((x) => x.toJson())),
      };
}

class OptionItem {
  OptionItem({
    this.productOptionItemId,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
  });

  int? productOptionItemId;
  String? name;
  dynamic price;
  String? imageUrl;
  String? description;

  factory OptionItem.fromJson(Map<String, dynamic> json) => OptionItem(
        productOptionItemId: json["ProductOptionItemId"],
        name: json["Name"],
        price: json["Price"],
        imageUrl: json["ImageUrl"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "ProductOptionItemId": productOptionItemId,
        "Name": name,
        "Price": price,
        "ImageUrl": imageUrl,
        "Description": description,
      };
}

class ProductItemPriceModel {
  ProductItemPriceModel({
    this.id,
    this.price,
    this.offerPrice,
    this.currancyDisplayName,
    this.size,
    this.weightUnitId,
  });

  int? id;
  dynamic price;
  dynamic offerPrice;
  String? currancyDisplayName;
  String? size;
  dynamic weightUnitId;

  factory ProductItemPriceModel.fromJson(Map<String, dynamic> json) =>
      ProductItemPriceModel(
        id: json["Id"],
        price: json["Price"],
        offerPrice: json["OfferPrice"],
        currancyDisplayName: json["CurrancyDisplayName"],
        size: json["Size"],
        weightUnitId: json["WeightUnitId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Price": price,
        "OfferPrice": offerPrice,
        "CurrancyDisplayName": currancyDisplayName,
        "Size": size,
        "WeightUnitId": weightUnitId,
      };
}

class ProductItemPrices {
  final int? id;
  final dynamic price;
  final dynamic offerPrice;
  final String? currancyDisplayName;
  final String? size;
  final dynamic weightUnitId;

  ProductItemPrices({
    this.id,
    this.price,
    this.offerPrice,
    this.currancyDisplayName,
    this.size,
    this.weightUnitId,
  });

  ProductItemPrices.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        price = json['Price'] as dynamic,
        offerPrice = json['OfferPrice'] as dynamic,
        currancyDisplayName = json['CurrancyDisplayName'] as String?,
        size = json['Size'] as String?,
        weightUnitId = json['WeightUnitId'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Price': price,
        'OfferPrice': offerPrice,
        'CurrancyDisplayName': currancyDisplayName,
        'Size': size,
        'WeightUnitId': weightUnitId
      };
}
