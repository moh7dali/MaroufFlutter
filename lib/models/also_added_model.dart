import 'package:Marouf/models/ordrer_details.dart';
import 'package:Marouf/models/products_model.dart';

class PeopleAlsoAddedModel {
  List<ProductItem>? productItems;
  bool? isSucceeded;
  List<Errors>? errors;
  dynamic totalNumberofResult;

  PeopleAlsoAddedModel({
    this.productItems,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  PeopleAlsoAddedModel.fromJson(Map<String, dynamic> json) {
    productItems = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Error'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();
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