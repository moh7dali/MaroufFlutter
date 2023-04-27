import 'package:Marouf/models/ordrer_details.dart';
import 'package:Marouf/models/products_model.dart';

class TradeMarkModel {
  final List<ProductItem>? data;
  final bool? isSucceeded;
  final List<Errors>? errors;

  TradeMarkModel({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  TradeMarkModel.fromJson(Map<String, dynamic> json)
      : data = (json['ProductItems'] as List?)?.map((dynamic e) => ProductItem.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'ProductItems' : data?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}
