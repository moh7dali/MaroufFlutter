import 'package:Marouf/models/main_response.dart';

class MyRewards {
  final List<RewardModel>? rewardModel;
  final bool? isSucceeded;
  final List<Error>? errors;
  final int? totalNumberofResult;

  MyRewards({
    this.rewardModel,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  MyRewards.fromJson(Map<String, dynamic> json)
      : rewardModel = (json['RewardModel'] as List?)?.map((dynamic e) => RewardModel.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberofResult = json['TotalNumberofResult'] as int?;

  Map<String, dynamic> toJson() => {
    'RewardModel' : rewardModel?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList(),
    'TotalNumberofResult' : totalNumberofResult
  };
}

class RewardModel {
  final int? id;
  final String? title;
  final String? description;
  final String? expiryDate;
  final bool? isExpired;
  final String? imageUrl;
  final bool? hasTaken;
  final String? rewardUrlLink;
  final RewardBrand? rewardBrand;

  RewardModel({
    this.id,
    this.title,
    this.description,
    this.expiryDate,
    this.isExpired,
    this.imageUrl,
    this.hasTaken,
    this.rewardUrlLink,
    this.rewardBrand,
  });

  RewardModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        title = json['Title'] as String?,
        description = json['Description'] as String?,
        expiryDate = json['ExpiryDate'] as String?,
        isExpired = json['IsExpired'] as bool?,
        imageUrl = json['ImageUrl'] as String?,
        hasTaken = json['HasTaken'] as bool?,
        rewardUrlLink = json['RewardUrlLink'] as String?,
        rewardBrand = (json['RewardBrand'] as Map<String,dynamic>?) != null ? RewardBrand.fromJson(json['RewardBrand'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Title' : title,
    'Description' : description,
    'ExpiryDate' : expiryDate,
    'IsExpired' : isExpired,
    'ImageUrl' : imageUrl,
    'HasTaken' : hasTaken,
    'RewardUrlLink' : rewardUrlLink,
    'RewardBrand' : rewardBrand?.toJson()
  };
}

class RewardBrand {
  final int? id;
  final String? name;
  final String? imageURL;

  RewardBrand({
    this.id,
    this.name,
    this.imageURL,
  });

  RewardBrand.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        imageURL = json['ImageURL'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'ImageURL' : imageURL
  };
}