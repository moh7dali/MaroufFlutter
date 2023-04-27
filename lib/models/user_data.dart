import 'package:Marouf/models/main_response.dart';

class UserData {
  final Data? data;
  final bool? isSucceeded;
  final List<Error>? errors;

  UserData({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  UserData.fromJson(Map<String, dynamic> json)
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
  final String? fullName;
  final dynamic cashBalance;
  final String? mobileNumber;

  Data({
    this.id,
    this.fullName,
    this.cashBalance,
    this.mobileNumber,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        fullName = json['FullName'] as String?,
        cashBalance = json['CashBalance'] ,
        mobileNumber = json['MobileNumber'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'FullName' : fullName,
    'CashBalance' : cashBalance,
    'MobileNumber' : mobileNumber
  };
}
