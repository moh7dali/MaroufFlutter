
import 'package:Marouf/models/products_model.dart';

class OffersModel {
  List<FeaturedSearch>? featuredSearch;
  FeaturedBrands? featuredBrands;
  DiscountBrands? discountBrands;
  MerchantBrands? merchantBrands;
  List<RootCategories>? rootCategories;
  // List<HomeSliders>? homeSliders;
  List<ClassificationsProduct>? classificationsProduct;
  List<RootClassifications>? rootClassifications;
  CustomerFavoriteBrand? customerFavoriteBrand;
  int? tax;
  bool? isSucceeded;
  List<Errors>? errors;

  OffersModel({this.featuredSearch, this.featuredBrands, this.discountBrands, this.merchantBrands, this.rootCategories, this.classificationsProduct, this.rootClassifications, this.customerFavoriteBrand, this.tax, this.isSucceeded, this.errors});

  OffersModel.fromJson(Map<String, dynamic> json) {
    if(json["FeaturedSearch"] is List) {
      featuredSearch = json["FeaturedSearch"] == null ? null : (json["FeaturedSearch"] as List).map((e) => FeaturedSearch.fromJson(e)).toList();
    }
    if(json["FeaturedBrands"] is Map) {
      featuredBrands = json["FeaturedBrands"] == null ? null : FeaturedBrands.fromJson(json["FeaturedBrands"]);
    }
    if(json["DiscountBrands"] is Map) {
      discountBrands = json["DiscountBrands"] == null ? null : DiscountBrands.fromJson(json["DiscountBrands"]);
    }
    if(json["MerchantBrands"] is Map) {
      merchantBrands = json["MerchantBrands"] == null ? null : MerchantBrands.fromJson(json["MerchantBrands"]);
    }
    if(json["RootCategories"] is List) {
      rootCategories = json["RootCategories"] == null ? null : (json["RootCategories"] as List).map((e) => RootCategories.fromJson(e)).toList();
    }
    // if(json["HomeSliders"] is List) {
    //   homeSliders = json["HomeSliders"] == null ? null : (json["HomeSliders"] as List).map((e) => HomeSliders.fromJson(e)).toList();
    // }
    if(json["ClassificationsProduct"] is List) {
      classificationsProduct = json["ClassificationsProduct"] == null ? null : (json["ClassificationsProduct"] as List).map((e) => ClassificationsProduct.fromJson(e)).toList();
    }
    if(json["RootClassifications"] is List) {
      rootClassifications = json["RootClassifications"] == null ? null : (json["RootClassifications"] as List).map((e) => RootClassifications.fromJson(e)).toList();
    }
    if(json["CustomerFavoriteBrand"] is Map) {
      customerFavoriteBrand = json["CustomerFavoriteBrand"] == null ? null : CustomerFavoriteBrand.fromJson(json["CustomerFavoriteBrand"]);
    }
    if(json["Tax"] is int) {
      tax = json["Tax"];
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
    if(featuredSearch != null) {
      _data["FeaturedSearch"] = featuredSearch?.map((e) => e.toJson()).toList();
    }
    if(featuredBrands != null) {
      _data["FeaturedBrands"] = featuredBrands?.toJson();
    }
    if(discountBrands != null) {
      _data["DiscountBrands"] = discountBrands?.toJson();
    }
    if(merchantBrands != null) {
      _data["MerchantBrands"] = merchantBrands?.toJson();
    }
    if(rootCategories != null) {
      _data["RootCategories"] = rootCategories?.map((e) => e.toJson()).toList();
    }
    // if(homeSliders != null) {
    //   _data["HomeSliders"] = homeSliders?.map((e) => e.toJson()).toList();
    // }
    if(classificationsProduct != null) {
      _data["ClassificationsProduct"] = classificationsProduct?.map((e) => e.toJson()).toList();
    }
    if(rootClassifications != null) {
      _data["RootClassifications"] = rootClassifications?.map((e) => e.toJson()).toList();
    }
    if(customerFavoriteBrand != null) {
      _data["CustomerFavoriteBrand"] = customerFavoriteBrand?.toJson();
    }
    _data["Tax"] = tax;
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

class CustomerFavoriteBrand {
  List<BrandModel3>? brandModel;
  int? totalNumberofResult;

  CustomerFavoriteBrand({this.brandModel, this.totalNumberofResult});

  CustomerFavoriteBrand.fromJson(Map<String, dynamic> json) {
    if(json["BrandModel"] is List) {
      brandModel = json["BrandModel"] == null ? null : (json["BrandModel"] as List).map((e) => BrandModel3.fromJson(e)).toList();
    }
    if(json["TotalNumberofResult"] is int) {
      totalNumberofResult = json["TotalNumberofResult"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(brandModel != null) {
      _data["BrandModel"] = brandModel?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberofResult"] = totalNumberofResult;
    return _data;
  }
}

class BrandModel3 {
  int? id;
  String? name;
  String? imageUrl;
  String? openTime;
  String? closeTime;
  String? mostPopularImageUrl;
  String? mostPopularText;
  bool? hasDailyDish;
  bool? isComingSoon;
  int? orderDiscount;
  String? description;
  String? webSiteUrl;
  String? faceBookUrl;
  String? instagramUrl;
  String? tiwtterUrl;
  String? label;
  bool? isBusy;
  bool? isFreeDelivery;
  String? busyReason;
  List<ProductItems5>? productItems;
  int? productTotalNumberOfResult;
  bool? deliveredByUs;
  String? logoUrl;
  bool? isFavorite;
  int? orderRate;
  List<BrandRateDetails3>? brandRateDetails;
  int? numberOfOrderRate;
  String? marketingText;
  String? classifications;
  bool? supportScheduleOrder;
  bool? isOpen;
  String? openingHours;
  String? orderingHours;
  String? expectedDeliveryTime;
  bool? canRecieveOrder;
  bool? canOrderFromMerchant;
  String? reasonForStoppingOrder;

  BrandModel3({this.id, this.name, this.imageUrl, this.openTime, this.closeTime, this.mostPopularImageUrl, this.mostPopularText, this.hasDailyDish, this.isComingSoon, this.orderDiscount, this.description, this.webSiteUrl, this.faceBookUrl, this.instagramUrl, this.tiwtterUrl, this.label, this.isBusy, this.isFreeDelivery, this.busyReason, this.productItems, this.productTotalNumberOfResult, this.deliveredByUs, this.logoUrl, this.isFavorite, this.orderRate, this.brandRateDetails, this.numberOfOrderRate, this.marketingText, this.classifications, this.supportScheduleOrder, this.isOpen, this.openingHours, this.orderingHours, this.expectedDeliveryTime, this.canRecieveOrder, this.canOrderFromMerchant, this.reasonForStoppingOrder});

  BrandModel3.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["OpenTime"] is String) {
      openTime = json["OpenTime"];
    }
    if(json["CloseTime"] is String) {
      closeTime = json["CloseTime"];
    }
    if(json["MostPopularImageUrl"] is String) {
      mostPopularImageUrl = json["MostPopularImageUrl"];
    }
    if(json["MostPopularText"] is String) {
      mostPopularText = json["MostPopularText"];
    }
    if(json["HasDailyDish"] is bool) {
      hasDailyDish = json["HasDailyDish"];
    }
    if(json["IsComingSoon"] is bool) {
      isComingSoon = json["IsComingSoon"];
    }
    if(json["OrderDiscount"] is int) {
      orderDiscount = json["OrderDiscount"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["WebSiteUrl"] is String) {
      webSiteUrl = json["WebSiteUrl"];
    }
    if(json["FaceBookUrl"] is String) {
      faceBookUrl = json["FaceBookUrl"];
    }
    if(json["InstagramUrl"] is String) {
      instagramUrl = json["InstagramUrl"];
    }
    if(json["TiwtterUrl"] is String) {
      tiwtterUrl = json["TiwtterUrl"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["IsBusy"] is bool) {
      isBusy = json["IsBusy"];
    }
    if(json["IsFreeDelivery"] is bool) {
      isFreeDelivery = json["IsFreeDelivery"];
    }
    if(json["BusyReason"] is String) {
      busyReason = json["BusyReason"];
    }
    if(json["ProductItems"] is List) {
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItems5.fromJson(e)).toList();
    }
    if(json["ProductTotalNumberOfResult"] is int) {
      productTotalNumberOfResult = json["ProductTotalNumberOfResult"];
    }
    if(json["DeliveredByUs"] is bool) {
      deliveredByUs = json["DeliveredByUs"];
    }
    if(json["LogoUrl"] is String) {
      logoUrl = json["LogoUrl"];
    }
    if(json["IsFavorite"] is bool) {
      isFavorite = json["IsFavorite"];
    }
    if(json["OrderRate"] is int) {
      orderRate = json["OrderRate"];
    }
    if(json["BrandRateDetails"] is List) {
      brandRateDetails = json["BrandRateDetails"] == null ? null : (json["BrandRateDetails"] as List).map((e) => BrandRateDetails3.fromJson(e)).toList();
    }
    if(json["NumberOfOrderRate"] is int) {
      numberOfOrderRate = json["NumberOfOrderRate"];
    }
    if(json["MarketingText"] is String) {
      marketingText = json["MarketingText"];
    }
    if(json["Classifications"] is String) {
      classifications = json["Classifications"];
    }
    if(json["SupportScheduleOrder"] is bool) {
      supportScheduleOrder = json["SupportScheduleOrder"];
    }
    if(json["IsOpen"] is bool) {
      isOpen = json["IsOpen"];
    }
    if(json["OpeningHours"] is String) {
      openingHours = json["OpeningHours"];
    }
    if(json["OrderingHours"] is String) {
      orderingHours = json["OrderingHours"];
    }
    if(json["ExpectedDeliveryTime"] is String) {
      expectedDeliveryTime = json["ExpectedDeliveryTime"];
    }
    if(json["CanRecieveOrder"] is bool) {
      canRecieveOrder = json["CanRecieveOrder"];
    }
    if(json["CanOrderFromMerchant"] is bool) {
      canOrderFromMerchant = json["CanOrderFromMerchant"];
    }
    if(json["ReasonForStoppingOrder"] is String) {
      reasonForStoppingOrder = json["ReasonForStoppingOrder"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageUrl"] = imageUrl;
    _data["OpenTime"] = openTime;
    _data["CloseTime"] = closeTime;
    _data["MostPopularImageUrl"] = mostPopularImageUrl;
    _data["MostPopularText"] = mostPopularText;
    _data["HasDailyDish"] = hasDailyDish;
    _data["IsComingSoon"] = isComingSoon;
    _data["OrderDiscount"] = orderDiscount;
    _data["Description"] = description;
    _data["WebSiteUrl"] = webSiteUrl;
    _data["FaceBookUrl"] = faceBookUrl;
    _data["InstagramUrl"] = instagramUrl;
    _data["TiwtterUrl"] = tiwtterUrl;
    _data["Label"] = label;
    _data["IsBusy"] = isBusy;
    _data["IsFreeDelivery"] = isFreeDelivery;
    _data["BusyReason"] = busyReason;
    if(productItems != null) {
      _data["ProductItems"] = productItems?.map((e) => e.toJson()).toList();
    }
    _data["ProductTotalNumberOfResult"] = productTotalNumberOfResult;
    _data["DeliveredByUs"] = deliveredByUs;
    _data["LogoUrl"] = logoUrl;
    _data["IsFavorite"] = isFavorite;
    _data["OrderRate"] = orderRate;
    if(brandRateDetails != null) {
      _data["BrandRateDetails"] = brandRateDetails?.map((e) => e.toJson()).toList();
    }
    _data["NumberOfOrderRate"] = numberOfOrderRate;
    _data["MarketingText"] = marketingText;
    _data["Classifications"] = classifications;
    _data["SupportScheduleOrder"] = supportScheduleOrder;
    _data["IsOpen"] = isOpen;
    _data["OpeningHours"] = openingHours;
    _data["OrderingHours"] = orderingHours;
    _data["ExpectedDeliveryTime"] = expectedDeliveryTime;
    _data["CanRecieveOrder"] = canRecieveOrder;
    _data["CanOrderFromMerchant"] = canOrderFromMerchant;
    _data["ReasonForStoppingOrder"] = reasonForStoppingOrder;
    return _data;
  }
}

class BrandRateDetails3 {
  int? rateValue;
  int? numberOfOrderRated;

  BrandRateDetails3({this.rateValue, this.numberOfOrderRated});

  BrandRateDetails3.fromJson(Map<String, dynamic> json) {
    if(json["RateValue"] is int) {
      rateValue = json["RateValue"];
    }
    if(json["NumberOfOrderRated"] is int) {
      numberOfOrderRated = json["NumberOfOrderRated"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["RateValue"] = rateValue;
    _data["NumberOfOrderRated"] = numberOfOrderRated;
    return _data;
  }
}

class ProductItems5 {
  int? id;
  String? name;
  String? nameAr;
  String? url;
  String? imageUrl;
  String? productUrl;
  bool? hasOnlineOrdering;
  String? description;
  int? categoryId;
  List<ProductItemPrices6>? productItemPrices;
  List<ProductProperties6>? productProperties;
  TrademarkData6? trademarkData;
  bool? isMostPopular;
  String? label;
  bool? outOfStock;
  int? discount;
  String? referenceItemId;
  int? pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  String? trademarkName;
  int? brandId;
  String? brandName;
  String? brandImageUrl;
  String? brandLogoUrl;
  String? toDateLimit;
  int? limitationTypeId;
  int? stockQuantity;
  int? equivalentPoints;
  int? equivalentPointsValidity;

  ProductItems5({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});

  ProductItems5.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["NameAr"] is String) {
      nameAr = json["NameAr"];
    }
    if(json["Url"] is String) {
      url = json["Url"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductUrl"] is String) {
      productUrl = json["ProductUrl"];
    }
    if(json["HasOnlineOrdering"] is bool) {
      hasOnlineOrdering = json["HasOnlineOrdering"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["CategoryId"] is int) {
      categoryId = json["CategoryId"];
    }
    if(json["ProductItemPrices"] is List) {
      productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices6.fromJson(e)).toList();
    }
    if(json["ProductProperties"] is List) {
      productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties6.fromJson(e)).toList();
    }
    if(json["TrademarkData"] is Map) {
      trademarkData = json["TrademarkData"] == null ? null : TrademarkData6.fromJson(json["TrademarkData"]);
    }
    if(json["IsMostPopular"] is bool) {
      isMostPopular = json["IsMostPopular"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["OutOfStock"] is bool) {
      outOfStock = json["OutOfStock"];
    }
    if(json["Discount"] is int) {
      discount = json["Discount"];
    }
    if(json["ReferenceItemId"] is String) {
      referenceItemId = json["ReferenceItemId"];
    }
    if(json["PricingTypes"] is int) {
      pricingTypes = json["PricingTypes"];
    }
    if(json["HasOptions"] is bool) {
      hasOptions = json["HasOptions"];
    }
    if(json["IncludedInTotalPriceLimitation"] is bool) {
      includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
    }
    if(json["TrademarkName"] is String) {
      trademarkName = json["TrademarkName"];
    }
    if(json["BrandId"] is int) {
      brandId = json["BrandId"];
    }
    if(json["BrandName"] is String) {
      brandName = json["BrandName"];
    }
    if(json["BrandImageUrl"] is String) {
      brandImageUrl = json["BrandImageUrl"];
    }
    if(json["BrandLogoUrl"] is String) {
      brandLogoUrl = json["BrandLogoUrl"];
    }
    if(json["ToDateLimit"] is String) {
      toDateLimit = json["ToDateLimit"];
    }
    if(json["LimitationTypeId"] is int) {
      limitationTypeId = json["LimitationTypeId"];
    }
    if(json["StockQuantity"] is int) {
      stockQuantity = json["StockQuantity"];
    }
    if(json["EquivalentPoints"] is int) {
      equivalentPoints = json["EquivalentPoints"];
    }
    if(json["EquivalentPointsValidity"] is int) {
      equivalentPointsValidity = json["EquivalentPointsValidity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["NameAr"] = nameAr;
    _data["Url"] = url;
    _data["ImageUrl"] = imageUrl;
    _data["ProductUrl"] = productUrl;
    _data["HasOnlineOrdering"] = hasOnlineOrdering;
    _data["Description"] = description;
    _data["CategoryId"] = categoryId;
    if(productItemPrices != null) {
      _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
    }
    if(productProperties != null) {
      _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
    }
    if(trademarkData != null) {
      _data["TrademarkData"] = trademarkData?.toJson();
    }
    _data["IsMostPopular"] = isMostPopular;
    _data["Label"] = label;
    _data["OutOfStock"] = outOfStock;
    _data["Discount"] = discount;
    _data["ReferenceItemId"] = referenceItemId;
    _data["PricingTypes"] = pricingTypes;
    _data["HasOptions"] = hasOptions;
    _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
    _data["TrademarkName"] = trademarkName;
    _data["BrandId"] = brandId;
    _data["BrandName"] = brandName;
    _data["BrandImageUrl"] = brandImageUrl;
    _data["BrandLogoUrl"] = brandLogoUrl;
    _data["ToDateLimit"] = toDateLimit;
    _data["LimitationTypeId"] = limitationTypeId;
    _data["StockQuantity"] = stockQuantity;
    _data["EquivalentPoints"] = equivalentPoints;
    _data["EquivalentPointsValidity"] = equivalentPointsValidity;
    return _data;
  }
}

class TrademarkData6 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData6({this.id, this.name, this.imageUrl, this.description});

  TrademarkData6.fromJson(Map<String, dynamic> json) {
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

class ProductProperties6 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties6({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties6.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices6 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices6({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices6.fromJson(Map<String, dynamic> json) {
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

class RootClassifications {
  int? id;
  String? name;
  String? imageUrl;
  List<ProductItems4>? productItems;
  int? totalNumberOfResult;

  RootClassifications({this.id, this.name, this.imageUrl, this.productItems, this.totalNumberOfResult});

  RootClassifications.fromJson(Map<String, dynamic> json) {
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
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItems4.fromJson(e)).toList();
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

class ProductItems4 {
  int? id;
  String? name;
  String? nameAr;
  String? url;
  String? imageUrl;
  String? productUrl;
  bool? hasOnlineOrdering;
  String? description;
  int? categoryId;
  List<ProductItemPrices5>? productItemPrices;
  List<ProductProperties5>? productProperties;
  TrademarkData5? trademarkData;
  bool? isMostPopular;
  String? label;
  bool? outOfStock;
  int? discount;
  String? referenceItemId;
  int? pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  String? trademarkName;
  int? brandId;
  String? brandName;
  String? brandImageUrl;
  String? brandLogoUrl;
  String? toDateLimit;
  int? limitationTypeId;
  int? stockQuantity;
  int? equivalentPoints;
  int? equivalentPointsValidity;

  ProductItems4({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});

  ProductItems4.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["NameAr"] is String) {
      nameAr = json["NameAr"];
    }
    if(json["Url"] is String) {
      url = json["Url"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductUrl"] is String) {
      productUrl = json["ProductUrl"];
    }
    if(json["HasOnlineOrdering"] is bool) {
      hasOnlineOrdering = json["HasOnlineOrdering"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["CategoryId"] is int) {
      categoryId = json["CategoryId"];
    }
    if(json["ProductItemPrices"] is List) {
      productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices5.fromJson(e)).toList();
    }
    if(json["ProductProperties"] is List) {
      productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties5.fromJson(e)).toList();
    }
    if(json["TrademarkData"] is Map) {
      trademarkData = json["TrademarkData"] == null ? null : TrademarkData5.fromJson(json["TrademarkData"]);
    }
    if(json["IsMostPopular"] is bool) {
      isMostPopular = json["IsMostPopular"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["OutOfStock"] is bool) {
      outOfStock = json["OutOfStock"];
    }
    if(json["Discount"] is int) {
      discount = json["Discount"];
    }
    if(json["ReferenceItemId"] is String) {
      referenceItemId = json["ReferenceItemId"];
    }
    if(json["PricingTypes"] is int) {
      pricingTypes = json["PricingTypes"];
    }
    if(json["HasOptions"] is bool) {
      hasOptions = json["HasOptions"];
    }
    if(json["IncludedInTotalPriceLimitation"] is bool) {
      includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
    }
    if(json["TrademarkName"] is String) {
      trademarkName = json["TrademarkName"];
    }
    if(json["BrandId"] is int) {
      brandId = json["BrandId"];
    }
    if(json["BrandName"] is String) {
      brandName = json["BrandName"];
    }
    if(json["BrandImageUrl"] is String) {
      brandImageUrl = json["BrandImageUrl"];
    }
    if(json["BrandLogoUrl"] is String) {
      brandLogoUrl = json["BrandLogoUrl"];
    }
    if(json["ToDateLimit"] is String) {
      toDateLimit = json["ToDateLimit"];
    }
    if(json["LimitationTypeId"] is int) {
      limitationTypeId = json["LimitationTypeId"];
    }
    if(json["StockQuantity"] is int) {
      stockQuantity = json["StockQuantity"];
    }
    if(json["EquivalentPoints"] is int) {
      equivalentPoints = json["EquivalentPoints"];
    }
    if(json["EquivalentPointsValidity"] is int) {
      equivalentPointsValidity = json["EquivalentPointsValidity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["NameAr"] = nameAr;
    _data["Url"] = url;
    _data["ImageUrl"] = imageUrl;
    _data["ProductUrl"] = productUrl;
    _data["HasOnlineOrdering"] = hasOnlineOrdering;
    _data["Description"] = description;
    _data["CategoryId"] = categoryId;
    if(productItemPrices != null) {
      _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
    }
    if(productProperties != null) {
      _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
    }
    if(trademarkData != null) {
      _data["TrademarkData"] = trademarkData?.toJson();
    }
    _data["IsMostPopular"] = isMostPopular;
    _data["Label"] = label;
    _data["OutOfStock"] = outOfStock;
    _data["Discount"] = discount;
    _data["ReferenceItemId"] = referenceItemId;
    _data["PricingTypes"] = pricingTypes;
    _data["HasOptions"] = hasOptions;
    _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
    _data["TrademarkName"] = trademarkName;
    _data["BrandId"] = brandId;
    _data["BrandName"] = brandName;
    _data["BrandImageUrl"] = brandImageUrl;
    _data["BrandLogoUrl"] = brandLogoUrl;
    _data["ToDateLimit"] = toDateLimit;
    _data["LimitationTypeId"] = limitationTypeId;
    _data["StockQuantity"] = stockQuantity;
    _data["EquivalentPoints"] = equivalentPoints;
    _data["EquivalentPointsValidity"] = equivalentPointsValidity;
    return _data;
  }
}

class TrademarkData5 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData5({this.id, this.name, this.imageUrl, this.description});

  TrademarkData5.fromJson(Map<String, dynamic> json) {
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

class ProductProperties5 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties5({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties5.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices5 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices5({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices5.fromJson(Map<String, dynamic> json) {
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

class ClassificationsProduct {
  int? id;
  String? name;
  String? imageUrl;
  List<ProductItem>? productItems;
  int? totalNumberOfResult;

  ClassificationsProduct({this.id, this.name, this.imageUrl, this.productItems, this.totalNumberOfResult});

  ClassificationsProduct.fromJson(Map<String, dynamic> json) {
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

class ProductItems {
  int? id;
  String? name;
  String? nameAr;
  String? url;
  String? imageUrl;
  String? productUrl;
  bool? hasOnlineOrdering;
  String? description;
  int? categoryId;
  List<ProductItemPrices4>? productItemPrices;
  List<ProductProperties4>? productProperties;
  TrademarkData4? trademarkData;
  bool? isMostPopular;
  String? label;
  bool? outOfStock;
  int? discount;
  String? referenceItemId;
  int? pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  String? trademarkName;
  int? brandId;
  String? brandName;
  String? brandImageUrl;
  String? brandLogoUrl;
  String? toDateLimit;
  int? limitationTypeId;
  int? stockQuantity;
  int? equivalentPoints;
  int? equivalentPointsValidity;

  ProductItems({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});

  ProductItems.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["NameAr"] is String) {
      nameAr = json["NameAr"];
    }
    if(json["Url"] is String) {
      url = json["Url"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductUrl"] is String) {
      productUrl = json["ProductUrl"];
    }
    if(json["HasOnlineOrdering"] is bool) {
      hasOnlineOrdering = json["HasOnlineOrdering"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["CategoryId"] is int) {
      categoryId = json["CategoryId"];
    }
    if(json["ProductItemPrices"] is List) {
      productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices4.fromJson(e)).toList();
    }
    if(json["ProductProperties"] is List) {
      productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties4.fromJson(e)).toList();
    }
    if(json["TrademarkData"] is Map) {
      trademarkData = json["TrademarkData"] == null ? null : TrademarkData4.fromJson(json["TrademarkData"]);
    }
    if(json["IsMostPopular"] is bool) {
      isMostPopular = json["IsMostPopular"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["OutOfStock"] is bool) {
      outOfStock = json["OutOfStock"];
    }
    if(json["Discount"] is int) {
      discount = json["Discount"];
    }
    if(json["ReferenceItemId"] is String) {
      referenceItemId = json["ReferenceItemId"];
    }
    if(json["PricingTypes"] is int) {
      pricingTypes = json["PricingTypes"];
    }
    if(json["HasOptions"] is bool) {
      hasOptions = json["HasOptions"];
    }
    if(json["IncludedInTotalPriceLimitation"] is bool) {
      includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
    }
    if(json["TrademarkName"] is String) {
      trademarkName = json["TrademarkName"];
    }
    if(json["BrandId"] is int) {
      brandId = json["BrandId"];
    }
    if(json["BrandName"] is String) {
      brandName = json["BrandName"];
    }
    if(json["BrandImageUrl"] is String) {
      brandImageUrl = json["BrandImageUrl"];
    }
    if(json["BrandLogoUrl"] is String) {
      brandLogoUrl = json["BrandLogoUrl"];
    }
    if(json["ToDateLimit"] is String) {
      toDateLimit = json["ToDateLimit"];
    }
    if(json["LimitationTypeId"] is int) {
      limitationTypeId = json["LimitationTypeId"];
    }
    if(json["StockQuantity"] is int) {
      stockQuantity = json["StockQuantity"];
    }
    if(json["EquivalentPoints"] is int) {
      equivalentPoints = json["EquivalentPoints"];
    }
    if(json["EquivalentPointsValidity"] is int) {
      equivalentPointsValidity = json["EquivalentPointsValidity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["NameAr"] = nameAr;
    _data["Url"] = url;
    _data["ImageUrl"] = imageUrl;
    _data["ProductUrl"] = productUrl;
    _data["HasOnlineOrdering"] = hasOnlineOrdering;
    _data["Description"] = description;
    _data["CategoryId"] = categoryId;
    if(productItemPrices != null) {
      _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
    }
    if(productProperties != null) {
      _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
    }
    if(trademarkData != null) {
      _data["TrademarkData"] = trademarkData?.toJson();
    }
    _data["IsMostPopular"] = isMostPopular;
    _data["Label"] = label;
    _data["OutOfStock"] = outOfStock;
    _data["Discount"] = discount;
    _data["ReferenceItemId"] = referenceItemId;
    _data["PricingTypes"] = pricingTypes;
    _data["HasOptions"] = hasOptions;
    _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
    _data["TrademarkName"] = trademarkName;
    _data["BrandId"] = brandId;
    _data["BrandName"] = brandName;
    _data["BrandImageUrl"] = brandImageUrl;
    _data["BrandLogoUrl"] = brandLogoUrl;
    _data["ToDateLimit"] = toDateLimit;
    _data["LimitationTypeId"] = limitationTypeId;
    _data["StockQuantity"] = stockQuantity;
    _data["EquivalentPoints"] = equivalentPoints;
    _data["EquivalentPointsValidity"] = equivalentPointsValidity;
    return _data;
  }
}

class TrademarkData4 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData4({this.id, this.name, this.imageUrl, this.description});

  TrademarkData4.fromJson(Map<String, dynamic> json) {
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

class ProductProperties4 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties4({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties4.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices4 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices4({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices4.fromJson(Map<String, dynamic> json) {
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

// class HomeSliders {
//   int? id;
//   String? productName;
//   int? productItemId;
//   bool? hasProduct;
//   String? imageUrl;
//   bool? outOfStock;
//   int? brandId;
//   int? assignTypeId;
//   String? brandName;
//   int? categoryId;
//   bool? hasSubCategory;
//
//   HomeSliders({this.id, this.productName, this.productItemId, this.hasProduct, this.imageUrl, this.outOfStock, this.brandId, this.assignTypeId, this.brandName, this.categoryId, this.hasSubCategory});
//
//   HomeSliders.fromJson(Map<String, dynamic> json) {
//     if(json["Id"] is int) {
//       id = json["Id"];
//     }
//     if(json["ProductName"] is String) {
//       productName = json["ProductName"];
//     }
//     if(json["ProductItemId"] is int) {
//       productItemId = json["ProductItemId"];
//     }
//     if(json["HasProduct"] is bool) {
//       hasProduct = json["HasProduct"];
//     }
//     if(json["ImageUrl"] is String) {
//       imageUrl = json["ImageUrl"];
//     }
//     if(json["OutOfStock"] is bool) {
//       outOfStock = json["OutOfStock"];
//     }
//     if(json["BrandId"] is int) {
//       brandId = json["BrandId"];
//     }
//     if(json["AssignTypeId"] is int) {
//       assignTypeId = json["AssignTypeId"];
//     }
//     if(json["BrandName"] is String) {
//       brandName = json["BrandName"];
//     }
//     if(json["CategoryId"] is int) {
//       categoryId = json["CategoryId"];
//     }
//     if(json["HasSubCategory"] is bool) {
//       hasSubCategory = json["HasSubCategory"];
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["Id"] = id;
//     _data["ProductName"] = productName;
//     _data["ProductItemId"] = productItemId;
//     _data["HasProduct"] = hasProduct;
//     _data["ImageUrl"] = imageUrl;
//     _data["OutOfStock"] = outOfStock;
//     _data["BrandId"] = brandId;
//     _data["AssignTypeId"] = assignTypeId;
//     _data["BrandName"] = brandName;
//     _data["CategoryId"] = categoryId;
//     _data["HasSubCategory"] = hasSubCategory;
//     return _data;
//   }
// }

class RootCategories {
  int? id;
  String? name;
  String? backgroundImageUrl;
  bool? hasSubCategory;
  String? webUrl;
  bool? canBeOrdered;
  String? openingHours;
  List<dynamic>? subItemCategoreis;
  List<ProductItem>? productItem;

  RootCategories({this.id, this.name, this.backgroundImageUrl, this.hasSubCategory, this.webUrl, this.canBeOrdered, this.openingHours, this.subItemCategoreis, this.productItem});

  RootCategories.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["BackgroundImageUrl"] is String) {
      backgroundImageUrl = json["BackgroundImageUrl"];
    }
    if(json["HasSubCategory"] is bool) {
      hasSubCategory = json["HasSubCategory"];
    }
    if(json["WebUrl"] is String) {
      webUrl = json["WebUrl"];
    }
    if(json["CanBeOrdered"] is bool) {
      canBeOrdered = json["CanBeOrdered"];
    }
    if(json["OpeningHours"] is String) {
      openingHours = json["OpeningHours"];
    }
    if(json["SubItemCategoreis"] is List) {
      subItemCategoreis = json["SubItemCategoreis"] ?? [];
    }
    if(json["ProductItem"] is List) {
      productItem = json["ProductItem"] == null ? null : (json["ProductItem"] as List).map((e) => ProductItem.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["BackgroundImageUrl"] = backgroundImageUrl;
    _data["HasSubCategory"] = hasSubCategory;
    _data["WebUrl"] = webUrl;
    _data["CanBeOrdered"] = canBeOrdered;
    _data["OpeningHours"] = openingHours;
    if(subItemCategoreis != null) {
      _data["SubItemCategoreis"] = subItemCategoreis;
    }
    if(productItem != null) {
      _data["ProductItem"] = productItem?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

// class ProductItem {
//   int? id;
//   String? name;
//   String? nameAr;
//   String? url;
//   String? imageUrl;
//   String? productUrl;
//   bool? hasOnlineOrdering;
//   String? description;
//   int? categoryId;
//   List<ProductItemPrices3>? productItemPrices;
//   List<ProductProperties3>? productProperties;
//   TrademarkData3? trademarkData;
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
//   ProductItem({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});
//
//   ProductItem.fromJson(Map<String, dynamic> json) {
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
//       productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices3.fromJson(e)).toList();
//     }
//     if(json["ProductProperties"] is List) {
//       productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties3.fromJson(e)).toList();
//     }
//     if(json["TrademarkData"] is Map) {
//       trademarkData = json["TrademarkData"] == null ? null : TrademarkData3.fromJson(json["TrademarkData"]);
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

class TrademarkData3 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData3({this.id, this.name, this.imageUrl, this.description});

  TrademarkData3.fromJson(Map<String, dynamic> json) {
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

class ProductProperties3 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties3({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties3.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices3 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices3({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices3.fromJson(Map<String, dynamic> json) {
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

class MerchantBrands {
  List<BrandModel2>? brandModel;
  int? totalNumberofResult;

  MerchantBrands({this.brandModel, this.totalNumberofResult});

  MerchantBrands.fromJson(Map<String, dynamic> json) {
    if(json["BrandModel"] is List) {
      brandModel = json["BrandModel"] == null ? null : (json["BrandModel"] as List).map((e) => BrandModel2.fromJson(e)).toList();
    }
    if(json["TotalNumberofResult"] is int) {
      totalNumberofResult = json["TotalNumberofResult"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(brandModel != null) {
      _data["BrandModel"] = brandModel?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberofResult"] = totalNumberofResult;
    return _data;
  }
}

class BrandModel2 {
  int? id;
  String? name;
  String? imageUrl;
  String? openTime;
  String? closeTime;
  String? mostPopularImageUrl;
  String? mostPopularText;
  bool? hasDailyDish;
  bool? isComingSoon;
  int? orderDiscount;
  String? description;
  String? webSiteUrl;
  String? faceBookUrl;
  String? instagramUrl;
  String? tiwtterUrl;
  String? label;
  bool? isBusy;
  bool? isFreeDelivery;
  String? busyReason;
  List<ProductItems2>? productItems;
  int? productTotalNumberOfResult;
  bool? deliveredByUs;
  String? logoUrl;
  bool? isFavorite;
  int? orderRate;
  List<BrandRateDetails2>? brandRateDetails;
  int? numberOfOrderRate;
  String? marketingText;
  String? classifications;
  bool? supportScheduleOrder;
  bool? isOpen;
  String? openingHours;
  String? orderingHours;
  String? expectedDeliveryTime;
  bool? canRecieveOrder;
  bool? canOrderFromMerchant;
  String? reasonForStoppingOrder;

  BrandModel2({this.id, this.name, this.imageUrl, this.openTime, this.closeTime, this.mostPopularImageUrl, this.mostPopularText, this.hasDailyDish, this.isComingSoon, this.orderDiscount, this.description, this.webSiteUrl, this.faceBookUrl, this.instagramUrl, this.tiwtterUrl, this.label, this.isBusy, this.isFreeDelivery, this.busyReason, this.productItems, this.productTotalNumberOfResult, this.deliveredByUs, this.logoUrl, this.isFavorite, this.orderRate, this.brandRateDetails, this.numberOfOrderRate, this.marketingText, this.classifications, this.supportScheduleOrder, this.isOpen, this.openingHours, this.orderingHours, this.expectedDeliveryTime, this.canRecieveOrder, this.canOrderFromMerchant, this.reasonForStoppingOrder});

  BrandModel2.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["OpenTime"] is String) {
      openTime = json["OpenTime"];
    }
    if(json["CloseTime"] is String) {
      closeTime = json["CloseTime"];
    }
    if(json["MostPopularImageUrl"] is String) {
      mostPopularImageUrl = json["MostPopularImageUrl"];
    }
    if(json["MostPopularText"] is String) {
      mostPopularText = json["MostPopularText"];
    }
    if(json["HasDailyDish"] is bool) {
      hasDailyDish = json["HasDailyDish"];
    }
    if(json["IsComingSoon"] is bool) {
      isComingSoon = json["IsComingSoon"];
    }
    if(json["OrderDiscount"] is int) {
      orderDiscount = json["OrderDiscount"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["WebSiteUrl"] is String) {
      webSiteUrl = json["WebSiteUrl"];
    }
    if(json["FaceBookUrl"] is String) {
      faceBookUrl = json["FaceBookUrl"];
    }
    if(json["InstagramUrl"] is String) {
      instagramUrl = json["InstagramUrl"];
    }
    if(json["TiwtterUrl"] is String) {
      tiwtterUrl = json["TiwtterUrl"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["IsBusy"] is bool) {
      isBusy = json["IsBusy"];
    }
    if(json["IsFreeDelivery"] is bool) {
      isFreeDelivery = json["IsFreeDelivery"];
    }
    if(json["BusyReason"] is String) {
      busyReason = json["BusyReason"];
    }
    if(json["ProductItems"] is List) {
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItems2.fromJson(e)).toList();
    }
    if(json["ProductTotalNumberOfResult"] is int) {
      productTotalNumberOfResult = json["ProductTotalNumberOfResult"];
    }
    if(json["DeliveredByUs"] is bool) {
      deliveredByUs = json["DeliveredByUs"];
    }
    if(json["LogoUrl"] is String) {
      logoUrl = json["LogoUrl"];
    }
    if(json["IsFavorite"] is bool) {
      isFavorite = json["IsFavorite"];
    }
    if(json["OrderRate"] is int) {
      orderRate = json["OrderRate"];
    }
    if(json["BrandRateDetails"] is List) {
      brandRateDetails = json["BrandRateDetails"] == null ? null : (json["BrandRateDetails"] as List).map((e) => BrandRateDetails2.fromJson(e)).toList();
    }
    if(json["NumberOfOrderRate"] is int) {
      numberOfOrderRate = json["NumberOfOrderRate"];
    }
    if(json["MarketingText"] is String) {
      marketingText = json["MarketingText"];
    }
    if(json["Classifications"] is String) {
      classifications = json["Classifications"];
    }
    if(json["SupportScheduleOrder"] is bool) {
      supportScheduleOrder = json["SupportScheduleOrder"];
    }
    if(json["IsOpen"] is bool) {
      isOpen = json["IsOpen"];
    }
    if(json["OpeningHours"] is String) {
      openingHours = json["OpeningHours"];
    }
    if(json["OrderingHours"] is String) {
      orderingHours = json["OrderingHours"];
    }
    if(json["ExpectedDeliveryTime"] is String) {
      expectedDeliveryTime = json["ExpectedDeliveryTime"];
    }
    if(json["CanRecieveOrder"] is bool) {
      canRecieveOrder = json["CanRecieveOrder"];
    }
    if(json["CanOrderFromMerchant"] is bool) {
      canOrderFromMerchant = json["CanOrderFromMerchant"];
    }
    if(json["ReasonForStoppingOrder"] is String) {
      reasonForStoppingOrder = json["ReasonForStoppingOrder"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageUrl"] = imageUrl;
    _data["OpenTime"] = openTime;
    _data["CloseTime"] = closeTime;
    _data["MostPopularImageUrl"] = mostPopularImageUrl;
    _data["MostPopularText"] = mostPopularText;
    _data["HasDailyDish"] = hasDailyDish;
    _data["IsComingSoon"] = isComingSoon;
    _data["OrderDiscount"] = orderDiscount;
    _data["Description"] = description;
    _data["WebSiteUrl"] = webSiteUrl;
    _data["FaceBookUrl"] = faceBookUrl;
    _data["InstagramUrl"] = instagramUrl;
    _data["TiwtterUrl"] = tiwtterUrl;
    _data["Label"] = label;
    _data["IsBusy"] = isBusy;
    _data["IsFreeDelivery"] = isFreeDelivery;
    _data["BusyReason"] = busyReason;
    if(productItems != null) {
      _data["ProductItems"] = productItems?.map((e) => e.toJson()).toList();
    }
    _data["ProductTotalNumberOfResult"] = productTotalNumberOfResult;
    _data["DeliveredByUs"] = deliveredByUs;
    _data["LogoUrl"] = logoUrl;
    _data["IsFavorite"] = isFavorite;
    _data["OrderRate"] = orderRate;
    if(brandRateDetails != null) {
      _data["BrandRateDetails"] = brandRateDetails?.map((e) => e.toJson()).toList();
    }
    _data["NumberOfOrderRate"] = numberOfOrderRate;
    _data["MarketingText"] = marketingText;
    _data["Classifications"] = classifications;
    _data["SupportScheduleOrder"] = supportScheduleOrder;
    _data["IsOpen"] = isOpen;
    _data["OpeningHours"] = openingHours;
    _data["OrderingHours"] = orderingHours;
    _data["ExpectedDeliveryTime"] = expectedDeliveryTime;
    _data["CanRecieveOrder"] = canRecieveOrder;
    _data["CanOrderFromMerchant"] = canOrderFromMerchant;
    _data["ReasonForStoppingOrder"] = reasonForStoppingOrder;
    return _data;
  }
}

class BrandRateDetails2 {
  int? rateValue;
  int? numberOfOrderRated;

  BrandRateDetails2({this.rateValue, this.numberOfOrderRated});

  BrandRateDetails2.fromJson(Map<String, dynamic> json) {
    if(json["RateValue"] is int) {
      rateValue = json["RateValue"];
    }
    if(json["NumberOfOrderRated"] is int) {
      numberOfOrderRated = json["NumberOfOrderRated"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["RateValue"] = rateValue;
    _data["NumberOfOrderRated"] = numberOfOrderRated;
    return _data;
  }
}

class ProductItems2 {
  int? id;
  String? name;
  String? nameAr;
  String? url;
  String? imageUrl;
  String? productUrl;
  bool? hasOnlineOrdering;
  String? description;
  int? categoryId;
  List<ProductItemPrices2>? productItemPrices;
  List<ProductProperties2>? productProperties;
  TrademarkData2? trademarkData;
  bool? isMostPopular;
  String? label;
  bool? outOfStock;
  int? discount;
  String? referenceItemId;
  int? pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  String? trademarkName;
  int? brandId;
  String? brandName;
  String? brandImageUrl;
  String? brandLogoUrl;
  String? toDateLimit;
  int? limitationTypeId;
  int? stockQuantity;
  int? equivalentPoints;
  int? equivalentPointsValidity;

  ProductItems2({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});

  ProductItems2.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["NameAr"] is String) {
      nameAr = json["NameAr"];
    }
    if(json["Url"] is String) {
      url = json["Url"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductUrl"] is String) {
      productUrl = json["ProductUrl"];
    }
    if(json["HasOnlineOrdering"] is bool) {
      hasOnlineOrdering = json["HasOnlineOrdering"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["CategoryId"] is int) {
      categoryId = json["CategoryId"];
    }
    if(json["ProductItemPrices"] is List) {
      productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices2.fromJson(e)).toList();
    }
    if(json["ProductProperties"] is List) {
      productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties2.fromJson(e)).toList();
    }
    if(json["TrademarkData"] is Map) {
      trademarkData = json["TrademarkData"] == null ? null : TrademarkData2.fromJson(json["TrademarkData"]);
    }
    if(json["IsMostPopular"] is bool) {
      isMostPopular = json["IsMostPopular"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["OutOfStock"] is bool) {
      outOfStock = json["OutOfStock"];
    }
    if(json["Discount"] is int) {
      discount = json["Discount"];
    }
    if(json["ReferenceItemId"] is String) {
      referenceItemId = json["ReferenceItemId"];
    }
    if(json["PricingTypes"] is int) {
      pricingTypes = json["PricingTypes"];
    }
    if(json["HasOptions"] is bool) {
      hasOptions = json["HasOptions"];
    }
    if(json["IncludedInTotalPriceLimitation"] is bool) {
      includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
    }
    if(json["TrademarkName"] is String) {
      trademarkName = json["TrademarkName"];
    }
    if(json["BrandId"] is int) {
      brandId = json["BrandId"];
    }
    if(json["BrandName"] is String) {
      brandName = json["BrandName"];
    }
    if(json["BrandImageUrl"] is String) {
      brandImageUrl = json["BrandImageUrl"];
    }
    if(json["BrandLogoUrl"] is String) {
      brandLogoUrl = json["BrandLogoUrl"];
    }
    if(json["ToDateLimit"] is String) {
      toDateLimit = json["ToDateLimit"];
    }
    if(json["LimitationTypeId"] is int) {
      limitationTypeId = json["LimitationTypeId"];
    }
    if(json["StockQuantity"] is int) {
      stockQuantity = json["StockQuantity"];
    }
    if(json["EquivalentPoints"] is int) {
      equivalentPoints = json["EquivalentPoints"];
    }
    if(json["EquivalentPointsValidity"] is int) {
      equivalentPointsValidity = json["EquivalentPointsValidity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["NameAr"] = nameAr;
    _data["Url"] = url;
    _data["ImageUrl"] = imageUrl;
    _data["ProductUrl"] = productUrl;
    _data["HasOnlineOrdering"] = hasOnlineOrdering;
    _data["Description"] = description;
    _data["CategoryId"] = categoryId;
    if(productItemPrices != null) {
      _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
    }
    if(productProperties != null) {
      _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
    }
    if(trademarkData != null) {
      _data["TrademarkData"] = trademarkData?.toJson();
    }
    _data["IsMostPopular"] = isMostPopular;
    _data["Label"] = label;
    _data["OutOfStock"] = outOfStock;
    _data["Discount"] = discount;
    _data["ReferenceItemId"] = referenceItemId;
    _data["PricingTypes"] = pricingTypes;
    _data["HasOptions"] = hasOptions;
    _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
    _data["TrademarkName"] = trademarkName;
    _data["BrandId"] = brandId;
    _data["BrandName"] = brandName;
    _data["BrandImageUrl"] = brandImageUrl;
    _data["BrandLogoUrl"] = brandLogoUrl;
    _data["ToDateLimit"] = toDateLimit;
    _data["LimitationTypeId"] = limitationTypeId;
    _data["StockQuantity"] = stockQuantity;
    _data["EquivalentPoints"] = equivalentPoints;
    _data["EquivalentPointsValidity"] = equivalentPointsValidity;
    return _data;
  }
}

class TrademarkData2 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData2({this.id, this.name, this.imageUrl, this.description});

  TrademarkData2.fromJson(Map<String, dynamic> json) {
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

class ProductProperties2 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties2({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties2.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices2 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices2({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices2.fromJson(Map<String, dynamic> json) {
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

class DiscountBrands {
  List<BrandModel1>? brandModel;
  int? totalNumberofResult;

  DiscountBrands({this.brandModel, this.totalNumberofResult});

  DiscountBrands.fromJson(Map<String, dynamic> json) {
    if(json["BrandModel"] is List) {
      brandModel = json["BrandModel"] == null ? null : (json["BrandModel"] as List).map((e) => BrandModel1.fromJson(e)).toList();
    }
    if(json["TotalNumberofResult"] is int) {
      totalNumberofResult = json["TotalNumberofResult"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(brandModel != null) {
      _data["BrandModel"] = brandModel?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberofResult"] = totalNumberofResult;
    return _data;
  }
}

class BrandModel1 {
  int? id;
  String? name;
  String? imageUrl;
  String? openTime;
  String? closeTime;
  String? mostPopularImageUrl;
  String? mostPopularText;
  bool? hasDailyDish;
  bool? isComingSoon;
  int? orderDiscount;
  String? description;
  String? webSiteUrl;
  String? faceBookUrl;
  String? instagramUrl;
  String? tiwtterUrl;
  String? label;
  bool? isBusy;
  bool? isFreeDelivery;
  String? busyReason;
  List<ProductItems1>? productItems;
  int? productTotalNumberOfResult;
  bool? deliveredByUs;
  String? logoUrl;
  bool? isFavorite;
  int? orderRate;
  List<BrandRateDetails1>? brandRateDetails;
  int? numberOfOrderRate;
  String? marketingText;
  String? classifications;
  bool? supportScheduleOrder;
  bool? isOpen;
  String? openingHours;
  String? orderingHours;
  String? expectedDeliveryTime;
  bool? canRecieveOrder;
  bool? canOrderFromMerchant;
  String? reasonForStoppingOrder;

  BrandModel1({this.id, this.name, this.imageUrl, this.openTime, this.closeTime, this.mostPopularImageUrl, this.mostPopularText, this.hasDailyDish, this.isComingSoon, this.orderDiscount, this.description, this.webSiteUrl, this.faceBookUrl, this.instagramUrl, this.tiwtterUrl, this.label, this.isBusy, this.isFreeDelivery, this.busyReason, this.productItems, this.productTotalNumberOfResult, this.deliveredByUs, this.logoUrl, this.isFavorite, this.orderRate, this.brandRateDetails, this.numberOfOrderRate, this.marketingText, this.classifications, this.supportScheduleOrder, this.isOpen, this.openingHours, this.orderingHours, this.expectedDeliveryTime, this.canRecieveOrder, this.canOrderFromMerchant, this.reasonForStoppingOrder});

  BrandModel1.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["OpenTime"] is String) {
      openTime = json["OpenTime"];
    }
    if(json["CloseTime"] is String) {
      closeTime = json["CloseTime"];
    }
    if(json["MostPopularImageUrl"] is String) {
      mostPopularImageUrl = json["MostPopularImageUrl"];
    }
    if(json["MostPopularText"] is String) {
      mostPopularText = json["MostPopularText"];
    }
    if(json["HasDailyDish"] is bool) {
      hasDailyDish = json["HasDailyDish"];
    }
    if(json["IsComingSoon"] is bool) {
      isComingSoon = json["IsComingSoon"];
    }
    if(json["OrderDiscount"] is int) {
      orderDiscount = json["OrderDiscount"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["WebSiteUrl"] is String) {
      webSiteUrl = json["WebSiteUrl"];
    }
    if(json["FaceBookUrl"] is String) {
      faceBookUrl = json["FaceBookUrl"];
    }
    if(json["InstagramUrl"] is String) {
      instagramUrl = json["InstagramUrl"];
    }
    if(json["TiwtterUrl"] is String) {
      tiwtterUrl = json["TiwtterUrl"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["IsBusy"] is bool) {
      isBusy = json["IsBusy"];
    }
    if(json["IsFreeDelivery"] is bool) {
      isFreeDelivery = json["IsFreeDelivery"];
    }
    if(json["BusyReason"] is String) {
      busyReason = json["BusyReason"];
    }
    if(json["ProductItems"] is List) {
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItems1.fromJson(e)).toList();
    }
    if(json["ProductTotalNumberOfResult"] is int) {
      productTotalNumberOfResult = json["ProductTotalNumberOfResult"];
    }
    if(json["DeliveredByUs"] is bool) {
      deliveredByUs = json["DeliveredByUs"];
    }
    if(json["LogoUrl"] is String) {
      logoUrl = json["LogoUrl"];
    }
    if(json["IsFavorite"] is bool) {
      isFavorite = json["IsFavorite"];
    }
    if(json["OrderRate"] is int) {
      orderRate = json["OrderRate"];
    }
    if(json["BrandRateDetails"] is List) {
      brandRateDetails = json["BrandRateDetails"] == null ? null : (json["BrandRateDetails"] as List).map((e) => BrandRateDetails1.fromJson(e)).toList();
    }
    if(json["NumberOfOrderRate"] is int) {
      numberOfOrderRate = json["NumberOfOrderRate"];
    }
    if(json["MarketingText"] is String) {
      marketingText = json["MarketingText"];
    }
    if(json["Classifications"] is String) {
      classifications = json["Classifications"];
    }
    if(json["SupportScheduleOrder"] is bool) {
      supportScheduleOrder = json["SupportScheduleOrder"];
    }
    if(json["IsOpen"] is bool) {
      isOpen = json["IsOpen"];
    }
    if(json["OpeningHours"] is String) {
      openingHours = json["OpeningHours"];
    }
    if(json["OrderingHours"] is String) {
      orderingHours = json["OrderingHours"];
    }
    if(json["ExpectedDeliveryTime"] is String) {
      expectedDeliveryTime = json["ExpectedDeliveryTime"];
    }
    if(json["CanRecieveOrder"] is bool) {
      canRecieveOrder = json["CanRecieveOrder"];
    }
    if(json["CanOrderFromMerchant"] is bool) {
      canOrderFromMerchant = json["CanOrderFromMerchant"];
    }
    if(json["ReasonForStoppingOrder"] is String) {
      reasonForStoppingOrder = json["ReasonForStoppingOrder"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageUrl"] = imageUrl;
    _data["OpenTime"] = openTime;
    _data["CloseTime"] = closeTime;
    _data["MostPopularImageUrl"] = mostPopularImageUrl;
    _data["MostPopularText"] = mostPopularText;
    _data["HasDailyDish"] = hasDailyDish;
    _data["IsComingSoon"] = isComingSoon;
    _data["OrderDiscount"] = orderDiscount;
    _data["Description"] = description;
    _data["WebSiteUrl"] = webSiteUrl;
    _data["FaceBookUrl"] = faceBookUrl;
    _data["InstagramUrl"] = instagramUrl;
    _data["TiwtterUrl"] = tiwtterUrl;
    _data["Label"] = label;
    _data["IsBusy"] = isBusy;
    _data["IsFreeDelivery"] = isFreeDelivery;
    _data["BusyReason"] = busyReason;
    if(productItems != null) {
      _data["ProductItems"] = productItems?.map((e) => e.toJson()).toList();
    }
    _data["ProductTotalNumberOfResult"] = productTotalNumberOfResult;
    _data["DeliveredByUs"] = deliveredByUs;
    _data["LogoUrl"] = logoUrl;
    _data["IsFavorite"] = isFavorite;
    _data["OrderRate"] = orderRate;
    if(brandRateDetails != null) {
      _data["BrandRateDetails"] = brandRateDetails?.map((e) => e.toJson()).toList();
    }
    _data["NumberOfOrderRate"] = numberOfOrderRate;
    _data["MarketingText"] = marketingText;
    _data["Classifications"] = classifications;
    _data["SupportScheduleOrder"] = supportScheduleOrder;
    _data["IsOpen"] = isOpen;
    _data["OpeningHours"] = openingHours;
    _data["OrderingHours"] = orderingHours;
    _data["ExpectedDeliveryTime"] = expectedDeliveryTime;
    _data["CanRecieveOrder"] = canRecieveOrder;
    _data["CanOrderFromMerchant"] = canOrderFromMerchant;
    _data["ReasonForStoppingOrder"] = reasonForStoppingOrder;
    return _data;
  }
}

class BrandRateDetails1 {
  int? rateValue;
  int? numberOfOrderRated;

  BrandRateDetails1({this.rateValue, this.numberOfOrderRated});

  BrandRateDetails1.fromJson(Map<String, dynamic> json) {
    if(json["RateValue"] is int) {
      rateValue = json["RateValue"];
    }
    if(json["NumberOfOrderRated"] is int) {
      numberOfOrderRated = json["NumberOfOrderRated"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["RateValue"] = rateValue;
    _data["NumberOfOrderRated"] = numberOfOrderRated;
    return _data;
  }
}

class ProductItems1 {
  int? id;
  String? name;
  String? nameAr;
  String? url;
  String? imageUrl;
  String? productUrl;
  bool? hasOnlineOrdering;
  String? description;
  int? categoryId;
  List<ProductItemPrices1>? productItemPrices;
  List<ProductProperties1>? productProperties;
  TrademarkData1? trademarkData;
  bool? isMostPopular;
  String? label;
  bool? outOfStock;
  int? discount;
  String? referenceItemId;
  int? pricingTypes;
  bool? hasOptions;
  bool? includedInTotalPriceLimitation;
  String? trademarkName;
  int? brandId;
  String? brandName;
  String? brandImageUrl;
  String? brandLogoUrl;
  String? toDateLimit;
  int? limitationTypeId;
  int? stockQuantity;
  int? equivalentPoints;
  int? equivalentPointsValidity;

  ProductItems1({this.id, this.name, this.nameAr, this.url, this.imageUrl, this.productUrl, this.hasOnlineOrdering, this.description, this.categoryId, this.productItemPrices, this.productProperties, this.trademarkData, this.isMostPopular, this.label, this.outOfStock, this.discount, this.referenceItemId, this.pricingTypes, this.hasOptions, this.includedInTotalPriceLimitation, this.trademarkName, this.brandId, this.brandName, this.brandImageUrl, this.brandLogoUrl, this.toDateLimit, this.limitationTypeId, this.stockQuantity, this.equivalentPoints, this.equivalentPointsValidity});

  ProductItems1.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["NameAr"] is String) {
      nameAr = json["NameAr"];
    }
    if(json["Url"] is String) {
      url = json["Url"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["ProductUrl"] is String) {
      productUrl = json["ProductUrl"];
    }
    if(json["HasOnlineOrdering"] is bool) {
      hasOnlineOrdering = json["HasOnlineOrdering"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["CategoryId"] is int) {
      categoryId = json["CategoryId"];
    }
    if(json["ProductItemPrices"] is List) {
      productItemPrices = json["ProductItemPrices"] == null ? null : (json["ProductItemPrices"] as List).map((e) => ProductItemPrices1.fromJson(e)).toList();
    }
    if(json["ProductProperties"] is List) {
      productProperties = json["ProductProperties"] == null ? null : (json["ProductProperties"] as List).map((e) => ProductProperties1.fromJson(e)).toList();
    }
    if(json["TrademarkData"] is Map) {
      trademarkData = json["TrademarkData"] == null ? null : TrademarkData1.fromJson(json["TrademarkData"]);
    }
    if(json["IsMostPopular"] is bool) {
      isMostPopular = json["IsMostPopular"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["OutOfStock"] is bool) {
      outOfStock = json["OutOfStock"];
    }
    if(json["Discount"] is int) {
      discount = json["Discount"];
    }
    if(json["ReferenceItemId"] is String) {
      referenceItemId = json["ReferenceItemId"];
    }
    if(json["PricingTypes"] is int) {
      pricingTypes = json["PricingTypes"];
    }
    if(json["HasOptions"] is bool) {
      hasOptions = json["HasOptions"];
    }
    if(json["IncludedInTotalPriceLimitation"] is bool) {
      includedInTotalPriceLimitation = json["IncludedInTotalPriceLimitation"];
    }
    if(json["TrademarkName"] is String) {
      trademarkName = json["TrademarkName"];
    }
    if(json["BrandId"] is int) {
      brandId = json["BrandId"];
    }
    if(json["BrandName"] is String) {
      brandName = json["BrandName"];
    }
    if(json["BrandImageUrl"] is String) {
      brandImageUrl = json["BrandImageUrl"];
    }
    if(json["BrandLogoUrl"] is String) {
      brandLogoUrl = json["BrandLogoUrl"];
    }
    if(json["ToDateLimit"] is String) {
      toDateLimit = json["ToDateLimit"];
    }
    if(json["LimitationTypeId"] is int) {
      limitationTypeId = json["LimitationTypeId"];
    }
    if(json["StockQuantity"] is int) {
      stockQuantity = json["StockQuantity"];
    }
    if(json["EquivalentPoints"] is int) {
      equivalentPoints = json["EquivalentPoints"];
    }
    if(json["EquivalentPointsValidity"] is int) {
      equivalentPointsValidity = json["EquivalentPointsValidity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["NameAr"] = nameAr;
    _data["Url"] = url;
    _data["ImageUrl"] = imageUrl;
    _data["ProductUrl"] = productUrl;
    _data["HasOnlineOrdering"] = hasOnlineOrdering;
    _data["Description"] = description;
    _data["CategoryId"] = categoryId;
    if(productItemPrices != null) {
      _data["ProductItemPrices"] = productItemPrices?.map((e) => e.toJson()).toList();
    }
    if(productProperties != null) {
      _data["ProductProperties"] = productProperties?.map((e) => e.toJson()).toList();
    }
    if(trademarkData != null) {
      _data["TrademarkData"] = trademarkData?.toJson();
    }
    _data["IsMostPopular"] = isMostPopular;
    _data["Label"] = label;
    _data["OutOfStock"] = outOfStock;
    _data["Discount"] = discount;
    _data["ReferenceItemId"] = referenceItemId;
    _data["PricingTypes"] = pricingTypes;
    _data["HasOptions"] = hasOptions;
    _data["IncludedInTotalPriceLimitation"] = includedInTotalPriceLimitation;
    _data["TrademarkName"] = trademarkName;
    _data["BrandId"] = brandId;
    _data["BrandName"] = brandName;
    _data["BrandImageUrl"] = brandImageUrl;
    _data["BrandLogoUrl"] = brandLogoUrl;
    _data["ToDateLimit"] = toDateLimit;
    _data["LimitationTypeId"] = limitationTypeId;
    _data["StockQuantity"] = stockQuantity;
    _data["EquivalentPoints"] = equivalentPoints;
    _data["EquivalentPointsValidity"] = equivalentPointsValidity;
    return _data;
  }
}

class TrademarkData1 {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  TrademarkData1({this.id, this.name, this.imageUrl, this.description});

  TrademarkData1.fromJson(Map<String, dynamic> json) {
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

class ProductProperties1 {
  String? name;
  String? value;
  int? type;
  String? imageUrl;
  int? id;

  ProductProperties1({this.name, this.value, this.type, this.imageUrl, this.id});

  ProductProperties1.fromJson(Map<String, dynamic> json) {
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

class ProductItemPrices1 {
  int? id;
  int? price;
  int? offerPrice;
  String? currancyDisplayName;
  String? size;
  int? weightUnitId;

  ProductItemPrices1({this.id, this.price, this.offerPrice, this.currancyDisplayName, this.size, this.weightUnitId});

  ProductItemPrices1.fromJson(Map<String, dynamic> json) {
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

class FeaturedBrands {
  List<BrandModel>? brandModel;
  int? totalNumberofResult;

  FeaturedBrands({this.brandModel, this.totalNumberofResult});

  FeaturedBrands.fromJson(Map<String, dynamic> json) {
    if(json["BrandModel"] is List) {
      brandModel = json["BrandModel"] == null ? null : (json["BrandModel"] as List).map((e) => BrandModel.fromJson(e)).toList();
    }
    if(json["TotalNumberofResult"] is int) {
      totalNumberofResult = json["TotalNumberofResult"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(brandModel != null) {
      _data["BrandModel"] = brandModel?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberofResult"] = totalNumberofResult;
    return _data;
  }
}

class BrandModel {
  int? id;
  String? name;
  String? imageUrl;
  String? openTime;
  String? closeTime;
  String? mostPopularImageUrl;
  String? mostPopularText;
  bool? hasDailyDish;
  bool? isComingSoon;
  int? orderDiscount;
  String? description;
  String? webSiteUrl;
  String? faceBookUrl;
  String? instagramUrl;
  String? tiwtterUrl;
  String? label;
  bool? isBusy;
  bool? isFreeDelivery;
  String? busyReason;
  List<ProductItems>? productItems;
  int? productTotalNumberOfResult;
  bool? deliveredByUs;
  String? logoUrl;
  bool? isFavorite;
  int? orderRate;
  List<BrandRateDetails>? brandRateDetails;
  int? numberOfOrderRate;
  String? marketingText;
  String? classifications;
  bool? supportScheduleOrder;
  bool? isOpen;
  String? openingHours;
  String? orderingHours;
  String? expectedDeliveryTime;
  bool? canRecieveOrder;
  bool? canOrderFromMerchant;
  String? reasonForStoppingOrder;

  BrandModel({this.id, this.name, this.imageUrl, this.openTime, this.closeTime, this.mostPopularImageUrl, this.mostPopularText, this.hasDailyDish, this.isComingSoon, this.orderDiscount, this.description, this.webSiteUrl, this.faceBookUrl, this.instagramUrl, this.tiwtterUrl, this.label, this.isBusy, this.isFreeDelivery, this.busyReason, this.productItems, this.productTotalNumberOfResult, this.deliveredByUs, this.logoUrl, this.isFavorite, this.orderRate, this.brandRateDetails, this.numberOfOrderRate, this.marketingText, this.classifications, this.supportScheduleOrder, this.isOpen, this.openingHours, this.orderingHours, this.expectedDeliveryTime, this.canRecieveOrder, this.canOrderFromMerchant, this.reasonForStoppingOrder});

  BrandModel.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageUrl"] is String) {
      imageUrl = json["ImageUrl"];
    }
    if(json["OpenTime"] is String) {
      openTime = json["OpenTime"];
    }
    if(json["CloseTime"] is String) {
      closeTime = json["CloseTime"];
    }
    if(json["MostPopularImageUrl"] is String) {
      mostPopularImageUrl = json["MostPopularImageUrl"];
    }
    if(json["MostPopularText"] is String) {
      mostPopularText = json["MostPopularText"];
    }
    if(json["HasDailyDish"] is bool) {
      hasDailyDish = json["HasDailyDish"];
    }
    if(json["IsComingSoon"] is bool) {
      isComingSoon = json["IsComingSoon"];
    }
    if(json["OrderDiscount"] is int) {
      orderDiscount = json["OrderDiscount"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["WebSiteUrl"] is String) {
      webSiteUrl = json["WebSiteUrl"];
    }
    if(json["FaceBookUrl"] is String) {
      faceBookUrl = json["FaceBookUrl"];
    }
    if(json["InstagramUrl"] is String) {
      instagramUrl = json["InstagramUrl"];
    }
    if(json["TiwtterUrl"] is String) {
      tiwtterUrl = json["TiwtterUrl"];
    }
    if(json["Label"] is String) {
      label = json["Label"];
    }
    if(json["IsBusy"] is bool) {
      isBusy = json["IsBusy"];
    }
    if(json["IsFreeDelivery"] is bool) {
      isFreeDelivery = json["IsFreeDelivery"];
    }
    if(json["BusyReason"] is String) {
      busyReason = json["BusyReason"];
    }
    if(json["ProductItems"] is List) {
      productItems = json["ProductItems"] == null ? null : (json["ProductItems"] as List).map((e) => ProductItems.fromJson(e)).toList();
    }
    if(json["ProductTotalNumberOfResult"] is int) {
      productTotalNumberOfResult = json["ProductTotalNumberOfResult"];
    }
    if(json["DeliveredByUs"] is bool) {
      deliveredByUs = json["DeliveredByUs"];
    }
    if(json["LogoUrl"] is String) {
      logoUrl = json["LogoUrl"];
    }
    if(json["IsFavorite"] is bool) {
      isFavorite = json["IsFavorite"];
    }
    if(json["OrderRate"] is int) {
      orderRate = json["OrderRate"];
    }
    if(json["BrandRateDetails"] is List) {
      brandRateDetails = json["BrandRateDetails"] == null ? null : (json["BrandRateDetails"] as List).map((e) => BrandRateDetails.fromJson(e)).toList();
    }
    if(json["NumberOfOrderRate"] is int) {
      numberOfOrderRate = json["NumberOfOrderRate"];
    }
    if(json["MarketingText"] is String) {
      marketingText = json["MarketingText"];
    }
    if(json["Classifications"] is String) {
      classifications = json["Classifications"];
    }
    if(json["SupportScheduleOrder"] is bool) {
      supportScheduleOrder = json["SupportScheduleOrder"];
    }
    if(json["IsOpen"] is bool) {
      isOpen = json["IsOpen"];
    }
    if(json["OpeningHours"] is String) {
      openingHours = json["OpeningHours"];
    }
    if(json["OrderingHours"] is String) {
      orderingHours = json["OrderingHours"];
    }
    if(json["ExpectedDeliveryTime"] is String) {
      expectedDeliveryTime = json["ExpectedDeliveryTime"];
    }
    if(json["CanRecieveOrder"] is bool) {
      canRecieveOrder = json["CanRecieveOrder"];
    }
    if(json["CanOrderFromMerchant"] is bool) {
      canOrderFromMerchant = json["CanOrderFromMerchant"];
    }
    if(json["ReasonForStoppingOrder"] is String) {
      reasonForStoppingOrder = json["ReasonForStoppingOrder"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageUrl"] = imageUrl;
    _data["OpenTime"] = openTime;
    _data["CloseTime"] = closeTime;
    _data["MostPopularImageUrl"] = mostPopularImageUrl;
    _data["MostPopularText"] = mostPopularText;
    _data["HasDailyDish"] = hasDailyDish;
    _data["IsComingSoon"] = isComingSoon;
    _data["OrderDiscount"] = orderDiscount;
    _data["Description"] = description;
    _data["WebSiteUrl"] = webSiteUrl;
    _data["FaceBookUrl"] = faceBookUrl;
    _data["InstagramUrl"] = instagramUrl;
    _data["TiwtterUrl"] = tiwtterUrl;
    _data["Label"] = label;
    _data["IsBusy"] = isBusy;
    _data["IsFreeDelivery"] = isFreeDelivery;
    _data["BusyReason"] = busyReason;
    if(productItems != null) {
      _data["ProductItems"] = productItems?.map((e) => e.toJson()).toList();
    }
    _data["ProductTotalNumberOfResult"] = productTotalNumberOfResult;
    _data["DeliveredByUs"] = deliveredByUs;
    _data["LogoUrl"] = logoUrl;
    _data["IsFavorite"] = isFavorite;
    _data["OrderRate"] = orderRate;
    if(brandRateDetails != null) {
      _data["BrandRateDetails"] = brandRateDetails?.map((e) => e.toJson()).toList();
    }
    _data["NumberOfOrderRate"] = numberOfOrderRate;
    _data["MarketingText"] = marketingText;
    _data["Classifications"] = classifications;
    _data["SupportScheduleOrder"] = supportScheduleOrder;
    _data["IsOpen"] = isOpen;
    _data["OpeningHours"] = openingHours;
    _data["OrderingHours"] = orderingHours;
    _data["ExpectedDeliveryTime"] = expectedDeliveryTime;
    _data["CanRecieveOrder"] = canRecieveOrder;
    _data["CanOrderFromMerchant"] = canOrderFromMerchant;
    _data["ReasonForStoppingOrder"] = reasonForStoppingOrder;
    return _data;
  }
}

class BrandRateDetails {
  int? rateValue;
  int? numberOfOrderRated;

  BrandRateDetails({this.rateValue, this.numberOfOrderRated});

  BrandRateDetails.fromJson(Map<String, dynamic> json) {
    if(json["RateValue"] is int) {
      rateValue = json["RateValue"];
    }
    if(json["NumberOfOrderRated"] is int) {
      numberOfOrderRated = json["NumberOfOrderRated"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["RateValue"] = rateValue;
    _data["NumberOfOrderRated"] = numberOfOrderRated;
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

class FeaturedSearch {
  int? id;
  String? name;
  String? imageUrl;

  FeaturedSearch({this.id, this.name, this.imageUrl});

  FeaturedSearch.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageURL"] is String) {
      imageUrl = json["ImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageURL"] = imageUrl;
    return _data;
  }
}