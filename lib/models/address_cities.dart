import 'package:Marouf/models/main_response.dart';

class AddressCities {
  final List<CityModel>? citiesList;
  final bool? isSucceeded;
  final List<Error>? errors;

  AddressCities({
    this.citiesList,
    this.isSucceeded,
    this.errors,
  });

  AddressCities.fromJson(Map<String, dynamic> json)
      : citiesList = (json['CitiesList'] as List?)?.map((dynamic e) => CityModel.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'CitiesList' : citiesList?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class CityModel {
  final int? id;
  final String? name;
  final double? taxValue;


  CityModel({
    this.id,
    this.name,
    this.taxValue,
  });

  CityModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        taxValue = json['TaxValue'] as double?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'TaxValue' : taxValue
  };
}