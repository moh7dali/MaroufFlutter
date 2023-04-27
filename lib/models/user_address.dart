import 'package:Marouf/models/main_response.dart';

class UserAddress {
  final List<Addresses>? addresses;
  final bool? isSucceeded;
  final List<Error>? errors;

  UserAddress({
    this.addresses,
    this.isSucceeded,
    this.errors,
  });

  UserAddress.fromJson(Map<String, dynamic> json)
      : addresses = (json['Addresses'] as List?)?.map((dynamic e) => Addresses.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Addresses' : addresses?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class Addresses {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final int? cityId;
  final String? cityName;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final int? areaId;
  final String? areaName;
  final bool? hasSubArea;
  final int? subAreaId;
  final String? subAreaName;
  final double? latitude;
  final double? longitude;
  final double? deliveryFees;

  Addresses({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.cityId,
    this.cityName,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.areaId,
    this.areaName,
    this.hasSubArea,
    this.subAreaId,
    this.subAreaName,
    this.latitude,
    this.longitude,
    this.deliveryFees,
  });

  Addresses.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        address = json['Address'] as String?,
        phone = json['Phone'] as String?,
        cityId = json['CityId'] as int?,
        cityName = json['CityName'] as String?,
        buildingNumber = json['BuildingNumber'] as String?,
        floor = json['Floor'] as String?,
        apartment = json['Apartment'] as String?,
        areaId = json['AreaId'] as int?,
        areaName = json['AreaName'] as String?,
        hasSubArea = json['HasSubArea'] as bool?,
        subAreaId = json['SubAreaId'] as int?,
        subAreaName = json['SubAreaName'] as String?,
        latitude = json['Latitude'] as double?,
        longitude = json['Longitude'] as double?,
        deliveryFees = json['DeliveryFees'] as double?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Address' : address,
    'Phone' : phone,
    'CityId' : cityId,
    'CityName' : cityName,
    'BuildingNumber' : buildingNumber,
    'Floor' : floor,
    'Apartment' : apartment,
    'AreaId' : areaId,
    'AreaName' : areaName,
    'HasSubArea' : hasSubArea,
    'SubAreaId' : subAreaId,
    'SubAreaName' : subAreaName,
    'Latitude' : latitude,
    'Longitude' : longitude,
    'DeliveryFees' : deliveryFees
  };
}
