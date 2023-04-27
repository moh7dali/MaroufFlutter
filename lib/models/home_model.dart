import 'main_response.dart';
import 'products_model.dart';
import 'slider_model.dart';

class HomeDataModel {
   List<ClassificationsProduct>? classificationsProduct;
  String? webSiteUrl;
  String? faceBookUrl;
  String? instagramUrl;
  String? tiwtterUrl;
  String? mobileNumber;
  SpecialProducts? specialProducts;
  BestSellerProducts? bestSellerProducts;
  SpecialOfferProducts? specialOfferProducts;
  NewArraivalProducts? newArraivalProducts;
  DealOfTheWeekProducts? dealOfTheWeekProducts;
  List<RootCategories>? rootCategories;
  List<SliderModel>? homeSliders;
  bool? isSucceeded;
  List<Error>? errors;

  HomeDataModel({
    this.classificationsProduct,
    this.webSiteUrl,
    this.faceBookUrl,
    this.instagramUrl,
    this.tiwtterUrl,
    this.mobileNumber,
    this.specialProducts,
    this.bestSellerProducts,
    this.specialOfferProducts,
    this.newArraivalProducts,
    this.dealOfTheWeekProducts,
    this.rootCategories,
    this.homeSliders,
    this.isSucceeded,
    this.errors,
  });

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    classificationsProduct = (json['ClassificationsProduct'] as List?)?.map((dynamic e) => ClassificationsProduct.fromJson(e as Map<String,dynamic>)).toList();
    webSiteUrl = json['WebSiteUrl'] as String?;
    faceBookUrl = json['FaceBookUrl'] as String?;
    instagramUrl = json['InstagramUrl'] as String?;
    tiwtterUrl = json['TiwtterUrl'] as String?;
    mobileNumber = json['MobileNumber'] as String?;
    specialProducts = (json['SpecialProducts'] as Map<String,dynamic>?) != null ? SpecialProducts.fromJson(json['SpecialProducts'] as Map<String,dynamic>) : null;
    bestSellerProducts = (json['BestSellerProducts'] as Map<String,dynamic>?) != null ? BestSellerProducts.fromJson(json['BestSellerProducts'] as Map<String,dynamic>) : null;
    specialOfferProducts = (json['SpecialOfferProducts'] as Map<String,dynamic>?) != null ? SpecialOfferProducts.fromJson(json['SpecialOfferProducts'] as Map<String,dynamic>) : null;
    newArraivalProducts = (json['NewArraivalProducts'] as Map<String,dynamic>?) != null ? NewArraivalProducts.fromJson(json['NewArraivalProducts'] as Map<String,dynamic>) : null;
    dealOfTheWeekProducts = (json['DealOfTheWeekProducts'] as Map<String,dynamic>?) != null ? DealOfTheWeekProducts.fromJson(json['DealOfTheWeekProducts'] as Map<String,dynamic>) : null;
    rootCategories = (json['RootCategories'] as List?)?.map((dynamic e) => RootCategories.fromJson(e as Map<String,dynamic>)).toList();
    homeSliders = (json['HomeSliders'] as List?)?.map((dynamic e) => SliderModel.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ClassificationsProduct'] = classificationsProduct?.map((e) => e.toJson()).toList();
    json['WebSiteUrl'] = webSiteUrl;
    json['FaceBookUrl'] = faceBookUrl;
    json['InstagramUrl'] = instagramUrl;
    json['TiwtterUrl'] = tiwtterUrl;
    json['MobileNumber'] = mobileNumber;
    json['SpecialProducts'] = specialProducts?.toJson();
    json['BestSellerProducts'] = bestSellerProducts?.toJson();
    json['SpecialOfferProducts'] = specialOfferProducts?.toJson();
    json['NewArraivalProducts'] = newArraivalProducts?.toJson();
    json['DealOfTheWeekProducts'] = dealOfTheWeekProducts?.toJson();
    json['RootCategories'] = rootCategories?.map((e) => e.toJson()).toList();
    json['HomeSliders'] = homeSliders?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    return json;
  }
}
class ClassificationsProduct {
  final int? id;
  final String? name;
  final String? imageUrl;
  final List<ProductItem>? productItems;
  final int? totalNumberOfResult;

  ClassificationsProduct({
    this.id,
    this.name,
    this.imageUrl,
    this.productItems,
    this.totalNumberOfResult,
  });

  ClassificationsProduct.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        imageUrl = json['ImageUrl'] as String?,
        productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberOfResult = json['TotalNumberOfResult'] as int?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'ImageUrl' : imageUrl,
    'ProductItems' : productItems?.map((e) => e.toJson()).toList(),
    'TotalNumberOfResult' : totalNumberOfResult
  };
}


class SpecialProducts {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  dynamic totalNumberofResult;

  SpecialProducts({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  SpecialProducts.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
    totalNumberofResult = json['TotalNumberofResult'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductItems'] = productItems?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    json['TotalNumberofResult'] = totalNumberofResult;
    return json;
  }
}



class ProductItemPrices {
  dynamic id;
  dynamic price;
  dynamic offerPrice;
  String? currancyDisplayName;
  String? size;
  dynamic weightUnitId;

  ProductItemPrices({
    this.id,
    this.price,
    this.offerPrice,
    this.currancyDisplayName,
    this.size,
    this.weightUnitId,
  });

  ProductItemPrices.fromJson(Map<String, dynamic> json) {
    id = json['Id'] as dynamic;
    price = json['Price'] as dynamic;
    offerPrice = json['OfferPrice'] as dynamic;
    currancyDisplayName = json['CurrancyDisplayName'] as String?;
    size = json['Size'] as String?;
    weightUnitId = json['WeightUnitId'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Id'] = id;
    json['Price'] = price;
    json['OfferPrice'] = offerPrice;
    json['CurrancyDisplayName'] = currancyDisplayName;
    json['Size'] = size;
    json['WeightUnitId'] = weightUnitId;
    return json;
  }
}

class ProductProperties {
  String? name;
  String? value;
  dynamic type;
  String? imageUrl;
  dynamic id;

  ProductProperties({
    this.name,
    this.value,
    this.type,
    this.imageUrl,
    this.id,
  });

  ProductProperties.fromJson(Map<String, dynamic> json) {
    name = json['Name'] as String?;
    value = json['Value'] as String?;
    type = json['Type'] as dynamic;
    imageUrl = json['ImageUrl'] as String?;
    id = json['Id'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Name'] = name;
    json['Value'] = value;
    json['Type'] = type;
    json['ImageUrl'] = imageUrl;
    json['Id'] = id;
    return json;
  }
}

class BestSellerProducts {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  dynamic totalNumberofResult;

  BestSellerProducts({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  BestSellerProducts.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
    totalNumberofResult = json['TotalNumberofResult'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductItems'] = productItems?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    json['TotalNumberofResult'] = totalNumberofResult;
    return json;
  }
}



class SpecialOfferProducts {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  dynamic totalNumberofResult;

  SpecialOfferProducts({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  SpecialOfferProducts.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
    totalNumberofResult = json['TotalNumberofResult'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductItems'] = productItems?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    json['TotalNumberofResult'] = totalNumberofResult;
    return json;
  }
}



class NewArraivalProducts {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  dynamic totalNumberofResult;

  NewArraivalProducts({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  NewArraivalProducts.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
    totalNumberofResult = json['TotalNumberofResult'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductItems'] = productItems?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    json['TotalNumberofResult'] = totalNumberofResult;
    return json;
  }
}



class DealOfTheWeekProducts {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Error>? errors;
  dynamic totalNumberofResult;

  DealOfTheWeekProducts({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  DealOfTheWeekProducts.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();
    totalNumberofResult = json['TotalNumberofResult'] as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ProductItems'] = productItems?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Error'] = errors?.map((e) => e.toJson()).toList();
    json['TotalNumberofResult'] = totalNumberofResult;
    return json;
  }
}


class RootCategories {
  dynamic id;
  bool? isMostPopular;
  String? name;
  String? backgroundImageUrl;
  bool? hasSubCategory;
  String? webUrl;
  bool? canBeOrdered;
  String? openingHours;
  List<dynamic>? subItemCategoreis;
  List<ProductItem>? productItem;

  RootCategories({
    this.id,
    this.isMostPopular,
    this.name,
    this.backgroundImageUrl,
    this.hasSubCategory,
    this.webUrl,
    this.canBeOrdered,
    this.openingHours,
    this.subItemCategoreis,
    this.productItem,
  });

  RootCategories.fromJson(Map<String, dynamic> json) {
    id = json['Id'] as dynamic;
    isMostPopular = json['IsMostPopular'] as bool?;
    name = json['Name'] as String?;
    backgroundImageUrl = json['BackgroundImageUrl'] as String?;
    hasSubCategory = json['HasSubCategory'] as bool?;
    webUrl = json['WebUrl'] as String?;
    canBeOrdered = json['CanBeOrdered'] as bool?;
    openingHours = json['OpeningHours'] as String?;
    subItemCategoreis = json['SubItemCategoreis'] as List?;
    productItem = (json['ProductItem'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Id'] = id;
    json['IsMostPopular'] = isMostPopular;
    json['Name'] = name;
    json['BackgroundImageUrl'] = backgroundImageUrl;
    json['HasSubCategory'] = hasSubCategory;
    json['WebUrl'] = webUrl;
    json['CanBeOrdered'] = canBeOrdered;
    json['OpeningHours'] = openingHours;
    json['SubItemCategoreis'] = subItemCategoreis;
    json['ProductItem'] = productItem?.map((e) => e.toJson()).toList();
    return json;
  }
}




