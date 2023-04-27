
import 'package:Marouf/models/products_model.dart';

class OffersInfoModel {
  Data? data;
  bool? isSucceeded;
  List<Errors>? errors;

  OffersInfoModel({this.data, this.isSucceeded, this.errors});

  OffersInfoModel.fromJson(Map<String, dynamic> json) {
    if(json["Data"] is Map) {
      data = json["Data"] == null ? null : Data.fromJson(json["Data"]);
    }
    if(json["IsSucceeded"] is bool) {
      isSucceeded = json["IsSucceeded"];
    }
    if(json["Errors"] is List) {
      errors = json["Errors"] == null ? null : (json["Errors"] as List).map((e) => Errors.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["Data"] = data?.toJson();
    }
    _data["IsSucceeded"] = isSucceeded;
    if(errors != null) {
      _data["Errors"] = errors?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Errors {
  int? errorCode;
  String? errorMessage;

  Errors({this.errorCode, this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    if(json["ErrorCode"] is int) {
      errorCode = json["ErrorCode"];
    }
    if(json["ErrorMessage"] is String) {
      errorMessage = json["ErrorMessage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ErrorCode"] = errorCode;
    _data["ErrorMessage"] = errorMessage;
    return _data;
  }
}

class Data {
  int? id;
  String? name;
  String? imageUrl;
  List<ProductItem>? productItems;
  int? totalNumberOfResult;

  Data({this.id, this.name, this.imageUrl, this.productItems, this.totalNumberOfResult});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductItems"] is List) {
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItem.fromJson(e)).toList();
    }
    if(json["TotalNumberOfResult"] is int) {
      totalNumberOfResult = json["TotalNumberOfResult"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageUrl"] = imageUrl;
    if(productItems != null) {
      _data["ProductItems"] = productItems?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberOfResult"] = totalNumberOfResult;
    return _data;
  }
}

// class ProductItems {
//   int? id;
//   String? name;
//   String? nameAr;
//   String? url;
//   String? imageUrl;
//   String? productUrl;
//   bool? hasOnlineOrdering;
//   String? description;
//   int? categoryId;
//   List<ProductItemPrices>? productItemPrices;
//   List<ProductProperties>? productProperties;
//   TrademarkData? trademarkData;
//   bool? isMostPopular;
//   String? label;
//   bool? outOfStock;
//   int? discount;
//   String? referenceItemId;
//   int? pricingTypes;
//   bool? hasOptions;
//   bool? includedInTotalPriceLimitation;
//   String? trademarkName;
//   int? brandId;
//   String? brandName;
//   String? brandImageUrl;
//   String? brandLogoUrl;
//   String? toDateLimit;
//   int? limitationTypeId;
//   int? stockQuantity;
//   int? equivalentPoints;
//   int? equivalentPointsValidity;
//
//   ProductItems({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});
//
//   ProductItems.fromJson(Map<String, dynamic> json) {
//     if(json["Id"] is int) {
//       id = json["Id"];
//     }
//     if(json["Name"] is String) {
//       name = json["Name"];
//     }
//     if(json["NameAr"] is String) {
//       nameAr = json["NameAr"];
//     }
//     if(json["Url"] is String) {
//       url = json["Url"];
//     }
//     if(json["ImageUrl"] is String) {
//       imageUrl = json["ImageUrl"];
//     }
//     if(json["ProductUrl"] is String) {
//       productUrl = json["ProductUrl"];
//     }
//     if(json["HasOnlineOrdering"] is bool) {
//       hasOnlineOrdering = json["HasOnlineOrdering"];
//     }
//     if(json["Description"] is String) {
//       description = json["Description"];
//     }
//     if(json["CategoryId"] is int) {
//       categoryId = json["CategoryId"];
//     }
//     if(json["ProductItemPrices"] is List) {
//       productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices.fromJson(e)).toList();
//     }
//     if(json["ProductProperties"] is List) {
//       productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties.fromJson(e)).toList();
//     }
//     if(json["TrademarkData"] is Map) {
//       trademarkData = json["TrademarkData"] == null ? null : TrademarkData.fromJson(json["TrademarkData"]);
//     }
//     if(json["IsMostPopular"] is bool) {
//       isMostPopular = json["IsMostPopular"];
//     }
//     if(json["Label"] is String) {
//       label = json["Label"];
//     }
//     if(json["OutOfStock"] is bool) {
//       outOfStock = json["OutOfStock"];
//     }
//     if(json["Discount"] is int) {
//       discount = json["Discount"];
//     }
//     if(json["ReferenceItemId"] is String) {
//       referenceItemId = json["ReferenceItemId"];
//     }
//     if(json["PricingTypes"] is int) {
//       pricingTypes = json["PricingTypes"];
//     }
//     if(json["HasOptions"] is bool) {
//       hasOptions = json["HasOptions"];
//     }
//     if(json["IncludedInTotalPriceLimitation"] is bool) {
//       includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
//     }
//     if(json["TrademarkName"] is String) {
//       trademarkName = json["TrademarkName"];
//     }
//     if(json["BrandId"] is int) {
//       brandId = json["BrandId"];
//     }
//     if(json["BrandName"] is String) {
//       brandName = json["BrandName"];
//     }
//     if(json["BrandImageUrl"] is String) {
//       brandImageUrl = json["BrandImageUrl"];
//     }
//     if(json["BrandLogoUrl"] is String) {
//       brandLogoUrl = json["BrandLogoUrl"];
//     }
//     if(json["ToDateLimit"] is String) {
//       toDateLimit = json["ToDateLimit"];
//     }
//     if(json["LimitationTypeId"] is int) {
//       limitationTypeId = json["LimitationTypeId"];
//     }
//     if(json["StockQuantity"] is int) {
//       stockQuantity = json["StockQuantity"];
//     }
//     if(json["EquivalentPoints"] is int) {
//       equivalentPoints = json["EquivalentPoints"];
//     }
//     if(json["EquivalentPointsValidity"] is int) {
//       equivalentPointsValidity = json["EquivalentPointsValidity"];
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["Id"] = id;
//     _data["Name"] = name;
//     _data["NameAr"] = nameAr;
//     _data["Url"] = url;
//     _data["ImageUrl"] = imageUrl;
//     _data["ProductUrl"] = productUrl;
//     _data["HasOnlineOrdering"] = hasOnlineOrdering;
//     _data["Description"] = description;
//     _data["CategoryId"] = categoryId;
//     if(productItemPrices != null) {
//       _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
//     }
//     if(productProperties != null) {
//       _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
//     }
//     if(trademarkData != null) {
//       _data["TrademarkData"] = trademarkData?.toJson();
//     }
//     _data["IsMostPopular"] = isMostPopular;
//     _data["Label"] = label;
//     _data["OutOfStock"] = outOfStock;
//     _data["Discount"] = discount;
//     _data["ReferenceItemId"] = referenceItemId;
//     _data["PricingTypes"] = pricingTypes;
//     _data["HasOptions"] = hasOptions;
//     _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
//     _data["TrademarkName"] = trademarkName;
//     _data["BrandId"] = brandId;
//     _data["BrandName"] = brandName;
//     _data["BrandImageUrl"] = brandImageUrl;
//     _data["BrandLogoUrl"] = brandLogoUrl;
//     _data["ToDateLimit"] = toDateLimit;
//     _data["LimitationTypeId"] = limitationTypeId;
//     _data["StockQuantity"] = stockQuantity;
//     _data["EquivalentPoints"] = equivalentPoints;
//     _data["EquivalentPointsValidity"] = equivalentPointsValidity;
//     return _data;
//   }
// }

class TrademarkData {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData({this.id, this.name, this.imageUrl, this.description});

  TrademarkData.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageURL"] is String) {
      imageUrl = json["ImageURL"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageURL"] = imageUrl;
    _data["Description"] = description;
    return _data;
  }
}

class ProductProperties {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties.fromJson(Map<String, dynamic> json) {
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["Value"] is String) {
      value = json["Value"];
    }
    if(json["Type"] is int) {
      type = json["Type"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["Id"] is int) {
      id = json["Id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Name"] = name;
    _data["Value"] = value;
    _data["Type"] = type;
    _data["ImageUrl"] = imageUrl;
    _data["Id"] = id;
    return _data;
  }
}

class ProductItemPrices {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Price"] is int) {
      price = json["Price"];
    }
    if(json["OfferPrice"] is int) {
      offerPrice = json["OfferPrice"];
    }
    if(json["CurrancyDisplayName"] is String) {
      currancyDisplayName = json["CurrancyDisplayName"];
    }
    if(json["Size"] is String) {
      size = json["Size"];
    }
    if(json["WeightUnitId"] is int) {
      weightUnitId = json["WeightUnitId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Price"] = price;
    _data["OfferPrice"] = offerPrice;
    _data["CurrancyDisplayName"] = currancyDisplayName;
    _data["Size"] = size;
    _data["WeightUnitId"] = weightUnitId;
    return _data;
  }
}