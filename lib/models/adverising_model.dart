import 'package:Marouf/models/main_response.dart';


class AdvertisingModel {
  final Data? data;
  final bool? isSucceeded;
  final List<Error>? errors;

  AdvertisingModel({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  AdvertisingModel.fromJson(Map<String, dynamic> json)
      : data = (json['Data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['Data'] as Map<String,dynamic>) : null,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Data' : data?.toJson(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? name;
  final List<Images>? images;
  final int? categoryId;
  final int? brandId;
  final int? productId;

  Data({
    this.id,
    this.name,
    this.images,
    this.categoryId,
    this.brandId,
    this.productId,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        images = (json['Images'] as List?)?.map((dynamic e) => Images.fromJson(e as Map<String,dynamic>)).toList(),
        categoryId = json['CategoryId'] as int?,
        brandId = json['BrandId'] as int?,
        productId = json['ProductId'] as int?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Images' : images?.map((e) => e.toJson()).toList(),
    'CategoryId' : categoryId,
    'BrandId' : brandId,
    'ProductId' : productId
  };
}

class Images {
  final int? id;
  final String? imageUrl;

  Images({
    this.id,
    this.imageUrl,
  });

  Images.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        imageUrl = json['ImageUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'ImageUrl' : imageUrl
  };
}
