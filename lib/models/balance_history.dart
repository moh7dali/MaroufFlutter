import 'package:Marouf/models/main_response.dart';

class BalanceHistory {
  final List<UserBalanceHistoryModel>? userBalanceHistoryModel;
  final bool? isSucceeded;
  final List<Error>? errors;
  final int? totalNumberofResult;

  BalanceHistory({
    this.userBalanceHistoryModel,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  BalanceHistory.fromJson(Map<String, dynamic> json)
      : userBalanceHistoryModel = (json['UserBalanceHistoryModel'] as List?)?.map((dynamic e) => UserBalanceHistoryModel.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberofResult = json['TotalNumberofResult'] as int?;

  Map<String, dynamic> toJson() => {
    'UserBalanceHistoryModel' : userBalanceHistoryModel?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList(),
    'TotalNumberofResult' : totalNumberofResult
  };
}

class UserBalanceHistoryModel {
  final int? numberOfPoints;
  final String? creationDate;
  final String? expiryDate;
  final int? triggerType;
  final String? source;
  final int? currentStatus;
  final String? activationDate;
  final String? senderName;
  final String? receiverMobileNumber;

  UserBalanceHistoryModel({
    this.numberOfPoints,
    this.creationDate,
    this.expiryDate,
    this.triggerType,
    this.source,
    this.currentStatus,
    this.activationDate,
    this.senderName,
    this.receiverMobileNumber,
  });

  UserBalanceHistoryModel.fromJson(Map<String, dynamic> json)
      : numberOfPoints = json['NumberOfPoints'] as int?,
        creationDate = json['CreationDate'] as String?,
        expiryDate = json['ExpiryDate'] as String?,
        triggerType = json['TriggerType'] as int?,
        source = json['Source'] as String?,
        currentStatus = json['CurrentStatus'] as int?,
        activationDate = json['ActivationDate'] as String?,
        senderName = json['SenderName'] as String?,
        receiverMobileNumber = json['ReceiverMobileNumber'] as String?;

  Map<String, dynamic> toJson() => {
    'NumberOfPoints' : numberOfPoints,
    'CreationDate' : creationDate,
    'ExpiryDate' : expiryDate,
    'TriggerType' : triggerType,
    'Source' : source,
    'CurrentStatus' : currentStatus,
    'ActivationDate' : activationDate,
    'SenderName' : senderName,
    'ReceiverMobileNumber' : receiverMobileNumber
  };
}
