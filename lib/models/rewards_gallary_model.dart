import 'package:Marouf/models/main_response.dart';

class RewardsGallary {
  final List<Reward>? data;
  final bool? isSucceeded;
  final List<Error>? errors;

  RewardsGallary.RewardsGallery({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  RewardsGallary.fromJson(Map<String, dynamic> json)
      : data = (json['Data'] as List?)?.map((dynamic e) => Reward.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Data' : data?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class Reward {
  final int? id;
  final String? title;
  final String? description;
  final int? numberOfPoints;
  final String? imageUrl;

  Reward({
    this.id,
    this.title,
    this.description,
    this.numberOfPoints,
    this.imageUrl,
  });

  Reward.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        title = json['Title'] as String?,
        description = json['Description'] as String?,
        numberOfPoints = json['NumberOfPoints'] as int?,
        imageUrl = json['ImageUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Title' : title,
    'Description' : description,
    'NumberOfPoints' : numberOfPoints,
    'ImageUrl' : imageUrl
  };
}