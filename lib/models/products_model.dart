import 'dart:convert';

import 'package:Marouf/models/main_response.dart';

ProductModel productItemFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productItemToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.isMostPopular,
    this.id,
    this.name,
    this.openingHours,
    this.brandId,
    this.brandName,
    this.isOpen,
    this.hasDailyDish,
    this.tax,
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  bool? isMostPopular;
  int? id;
  dynamic name;
  dynamic openingHours;
  int? brandId;
  String? brandName;
  bool? isOpen;
  bool? hasDailyDish;
  dynamic tax;
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  int? totalNumberofResult;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    isMostPopular:
    json["IsMostPopular"] == null ? null : json["IsMostPopular"],
    id: json["Id"] == null ? null : json["Id"],
    name: json["Name"],
    openingHours: json["OpeningHours"],
    brandId: json["BrandId"] == null ? null : json["BrandId"],
    brandName: json["BrandName"] == null ? null : json["BrandName"],
    isOpen: json["IsOpen"] == null ? null : json["IsOpen"],
    hasDailyDish:
    json["HasDailyDish"] == null ? null : json["HasDailyDish"],
    tax: json["Tax"],
    productItems: json["ProductItems"] == null
        ? null
        : List<ProductItem>.from(
        json["ProductItems"].map((x) => ProductItem.fromJson(x))),
    isSucceeded: json["IsSucceeded"],
    errors: json["Errors"] == null
        ? null
        : List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
    totalNumberofResult: json["TotalNumberofResult"] == null
        ? null
        : json["TotalNumberofResult"],
  );

  Map<String, dynamic> toJson() => {
    "IsMostPopular": isMostPopular == null ? null : isMostPopular,
    "Id": id == null ? null : id,
    "Name": name,
    "OpeningHours": openingHours,
    "BrandId": brandId == null ? null : brandId,
    "BrandName": brandName == null ? null : brandName,
    "IsOpen": isOpen == null ? null : isOpen,
    "HasDailyDish": hasDailyDish == null ? null : hasDailyDish,
    "Tax": tax,
    "ProductItems": productItems == null
        ? null
        : List<dynamic>.from(productItems!.map((x) => x.toJson())),
    "IsSucceeded": isSucceeded,
    "Errors": errors == null
        ? null
        : List<dynamic>.from(errors!.map((x) => x.toJson())),
    "TotalNumberofResult":
    totalNumberofResult == null ? null : totalNumberofResult,
  };
}

class ProductItem {
  ProductItem({
    this.id,
    this.name,
    this.nameAr,
    this.url,
    this.imageUrl,
    this.productUrl,
    this.hasOnlineOrdering,
    this.description,
    this.categoryId,
    this.productItemPrices,
    this.productProperties,
    this.isMostPopular,
    this.label,
    this.outOfStock,
    this.discount,
    this.referenceItemId,
    this.pricingTypes,
    this.hasOptions,
    this.includedInTotalPriceLimitation,
    this.trademarkName,
    this.brandId,
    this.brandName,
    this.brandImageUrl,
    this.brandLogoUrl,
    this.toDateLimit,
    this.limitationTypeId,
    this.stockQuantity,
  });

  int? id;
  String? name;
  dynamic nameAr;
  String? url;
  String? imageUrl;
  dynamic productUrl;
  bool? hasOnlineOrdering;
  dynamic description;
  int? categoryId;
  List<ProductItemPrice>? productItemPrices;
  List<dynamic>? productProperties;
  bool? isMostPopular;
  dynamic label;
  bool? outOfStock;
  dynamic discount;
  dynamic referenceItemId;
  dynamic pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  dynamic trademarkName;
  int? brandId;
  String? brandName;
  dynamic brandImageUrl;
  dynamic brandLogoUrl;
  dynamic toDateLimit;
  dynamic limitationTypeId;
  dynamic stockQuantity;

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["Id"] == null ? null : json["Id"],
    name: json["Name"] == null ? null : json["Name"],
    nameAr: json["NameAr"],
    url: json["Url"] == null ? null : json["Url"],
    imageUrl: json["ImageUrl"] == null ? null : json["ImageUrl"],
    productUrl: json["ProductUrl"],
    hasOnlineOrdering: json["HasOnlineOrdering"] == null
        ? null
        : json["HasOnlineOrdering"],
    description: json["Description"],
    categoryId: json["CategoryId"] == null ? null : json["CategoryId"],
    productItemPrices: json["ProductItemPrices"] == null
        ? null
        : List<ProductItemPrice>.from(json["ProductItemPrices"]
        .map((x) => ProductItemPrice.fromJson(x))),
    productProperties: json["ProductProperties"] == null
        ? null
        : List<dynamic>.from(json["ProductProperties"].map((x) => x)),
    isMostPopular:
    json["IsMostPopular"] == null ? null : json["IsMostPopular"],
    label: json["Label"],
    outOfStock: json["OutOfStock"] == null ? null : json["OutOfStock"],
    discount: json["Discount"] == null ? null : json["Discount"],
    referenceItemId: json["ReferenceItemId"],
    pricingTypes:
    json["PricingTypes"] == null ? null : json["PricingTypes"],
    hasOptions: json["HasOptions"] == null ? null : json["HasOptions"],
    includedInTotalPriceLimitation:
    json["IncludedInTotalPriceLimitation"] == null
        ? null
        : json["IncludedInTotalPriceLimitation"],
    trademarkName: json["TrademarkName"],
    brandId: json["BrandId"] == null ? null : json["BrandId"],
    brandName: json["BrandName"] == null ? null : json["BrandName"],
    brandImageUrl: json["BrandImageUrl"],
    brandLogoUrl: json["BrandLogoUrl"],
    toDateLimit: json["ToDateLimit"],
    limitationTypeId: json["LimitationTypeId"],
    stockQuantity: json["StockQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "Name": name == null ? null : name,
    "NameAr": nameAr,
    "Url": url == null ? null : url,
    "ImageUrl": imageUrl == null ? null : imageUrl,
    "ProductUrl": productUrl,
    "HasOnlineOrdering":
    hasOnlineOrdering == null ? null : hasOnlineOrdering,
    "Description": description,
    "CategoryId": categoryId == null ? null : categoryId,
    "ProductItemPrices": productItemPrices == null
        ? null
        : List<dynamic>.from(productItemPrices!.map((x) => x.toJson())),
    "ProductProperties": productProperties == null
        ? null
        : List<dynamic>.from(productProperties!.map((x) => x)),
    "IsMostPopular": isMostPopular == null ? null : isMostPopular,
    "Label": label,
    "OutOfStock": outOfStock == null ? null : outOfStock,
    "Discount": discount == null ? null : discount,
    "ReferenceItemId": referenceItemId,
    "PricingTypes": pricingTypes == null ? null : pricingTypes,
    "HasOptions": hasOptions == null ? null : hasOptions,
    "IncludedInTotalPriceLimitation": includedInTotalPriceLimitation == null
        ? null
        : includedInTotalPriceLimitation,
    "TrademarkName": trademarkName,
    "BrandId": brandId == null ? null : brandId,
    "BrandName": brandName == null ? null : brandName,
    "BrandImageUrl": brandImageUrl,
    "BrandLogoUrl": brandLogoUrl,
    "ToDateLimit": toDateLimit,
    "LimitationTypeId": limitationTypeId,
    "StockQuantity": stockQuantity,
  };
}

class ProductItemPrice {
  ProductItemPrice({
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

  factory ProductItemPrice.fromJson(Map<String, dynamic> json) =>
      ProductItemPrice(
        id: json["Id"] == null ? null : json["Id"],
        price: json["Price"] == null ? null : json["Price"],
        offerPrice: json["OfferPrice"] == null ? null : json["OfferPrice"],
        currancyDisplayName: json["CurrancyDisplayName"] == null
            ? null
            : json["CurrancyDisplayName"],
        size: json["Size"] == null ? null : json["Size"],
        weightUnitId: json["WeightUnitId"],
      );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "Price": price == null ? null : price,
    "OfferPrice": offerPrice == null ? null : offerPrice,
    "CurrancyDisplayName":
    currancyDisplayName == null ? null : currancyDisplayName,
    "Size": size == null ? null : size,
    "WeightUnitId": weightUnitId,
  };
}

class TrademarkData {
  final int? id;
  final String? name;
  final String? imageURL;
  final String? description;

  TrademarkData({
    this.id,
    this.name,
    this.imageURL,
    this.description,
  });

  TrademarkData.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        imageURL = json['ImageURL'] as String?,
        description = json['Description'] as String?;

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'ImageURL': imageURL,
    'Description': description
  };
}
