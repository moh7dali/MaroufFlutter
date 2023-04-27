import 'package:Marouf/models/main_response.dart';

class BranchDetails {
  final String? name;
  final String? description;
  final String? mobile;
  final double? latitude;
  final double? longitude;
  final String? openingHours;
  final String? address;
  final List<BranchImageModel>? branchImageModel;
  final bool? isSucceeded;
  final List<Error>? errors;

  BranchDetails({
    this.name,
    this.description,
    this.mobile,
    this.latitude,
    this.longitude,
    this.openingHours,
    this.address,
    this.branchImageModel,
    this.isSucceeded,
    this.errors,
  });

  BranchDetails.fromJson(Map<String, dynamic> json)
      : name = json['Name'] as String?,
        description = json['Description'] as String?,
        mobile = json['Mobile'] as String?,
        latitude = json['Latitude'] as double?,
        longitude = json['Longitude'] as double?,
        openingHours = json['OpeningHours'] as String?,
        address = json['Address'] as String?,
        branchImageModel = (json['BranchImageModel'] as List?)?.map((dynamic e) => BranchImageModel.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Description' : description,
    'Mobile' : mobile,
    'Latitude' : latitude,
    'Longitude' : longitude,
    'OpeningHours' : openingHours,
    'Address' : address,
    'BranchImageModel' : branchImageModel?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class BranchImageModel {
  final int? id;
  final String? imageUrl;

  BranchImageModel({
    this.id,
    this.imageUrl,
  });

  BranchImageModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        imageUrl = json['ImageUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'ImageUrl' : imageUrl
  };
}