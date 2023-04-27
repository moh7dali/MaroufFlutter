// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

import 'package:Marouf/models/ordrer_details.dart';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  List<HomeSliders>? data;
  bool? isSucceeded;
  List<Errors>? errors;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    data: json["Data"] == null ? null : List<HomeSliders>.from(json["Data"].map((x) => HomeSliders.fromJson(x))),
    isSucceeded: json["IsSucceeded"] == null ? null : json["IsSucceeded"],
    errors: json["Errors"] == null
        ? null
        : List<Errors>.from(
        json["Errors"].map((x) => Errors.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "IsSucceeded": isSucceeded, "Errors": errors == null
        ? null
        : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class HomeSliders {
  HomeSliders({
    this.id,
    this.productName,
    this.productItemId,
    this.hasProduct,
    this.imageUrl,
    this.outOfStock,
    this.brandId,
    this.assignTypeId,
    this.brandName,
    this.categoryId,
    this.hasSubCategory,
  });

  int? id;
  dynamic productName;
  dynamic productItemId;
  bool? hasProduct;
  String? imageUrl;
  bool? outOfStock;
  dynamic brandId;
  int? assignTypeId;
  dynamic brandName;
  bool? hasSubCategory;
  dynamic categoryId;

  factory HomeSliders.fromJson(Map<String, dynamic> json) => HomeSliders(
    id: json["Id"] == null ? null : json["Id"],
    productName: json["ProductName"],
    productItemId: json["ProductItemId"],
    hasProduct: json["HasProduct"] == null ? null : json["HasProduct"],
    imageUrl: json["ImageUrl"] == null ? null : json["ImageUrl"],
    outOfStock: json["OutOfStock"] == null ? null : json["OutOfStock"],
    brandId: json["BrandId"],
    assignTypeId: json["AssignTypeId"] == null ? null : json["AssignTypeId"],
    brandName: json["BrandName"],
    hasSubCategory: json["HasSubCategory"] == null ? null : json["HasSubCategory"],
    categoryId: json["CategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "ProductName": productName,
    "ProductItemId": productItemId,
    "HasProduct": hasProduct == null ? null : hasProduct,
    "ImageUrl": imageUrl == null ? null : imageUrl,
    "OutOfStock": outOfStock == null ? null : outOfStock,
    "BrandId": brandId,
    "AssignTypeId": assignTypeId == null ? null : assignTypeId,
    "BrandName": brandName,
    "HasSubCategory": hasSubCategory == null ? null : hasSubCategory,
    "CategoryId": categoryId,
  };
}
