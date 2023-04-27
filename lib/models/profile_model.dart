import 'package:Marouf/models/main_response.dart';

class ProfileData {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? birthDate;
  final int? meritalStatusType;
  final String? wifeBirthdate;
  final String? anniversaryDate;
  final int? genderType;
  final String? countryName;
  final int? countryId;
  final String? userCode;
  final int? areaId;
  final String? email;
  final bool? isCustomer;
  final String? mobileNumber;
  final String? areaName;
  final int? cityId;
  final String? cityName;
  final bool? interestedInGlutenFree;
  final String? nationalityName;
  final int? nationality;
  final bool? isRider;
  final int? bikeModelId;
  final String? bikeName;
  final int? bikeModelYear;
  final bool? isHogMember;
  final String? hogMemberId;
  final String? companyName;
  final bool? isSucceeded;
  final List<Error>? errors;

  ProfileData({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.meritalStatusType,
    this.wifeBirthdate,
    this.anniversaryDate,
    this.genderType,
    this.countryName,
    this.countryId,
    this.userCode,
    this.areaId,
    this.email,
    this.isCustomer,
    this.mobileNumber,
    this.areaName,
    this.cityId,
    this.cityName,
    this.interestedInGlutenFree,
    this.nationalityName,
    this.nationality,
    this.isRider,
    this.bikeModelId,
    this.bikeName,
    this.bikeModelYear,
    this.isHogMember,
    this.hogMemberId,
    this.companyName,
    this.isSucceeded,
    this.errors,
  });

  ProfileData.fromJson(Map<String, dynamic> json)
      :
        id = json['Id'] as int?,
        firstName = json['FirstName'] as String?,
        lastName = json['LastName'] as String?,
        birthDate = json['BirthDate'] as String?,
        meritalStatusType = json['MeritalStatusType'] as int?,
        wifeBirthdate = json['WifeBirthdate'] as String?,
        anniversaryDate = json['AnniversaryDate'] as String?,
        genderType = json['GenderType'] as int?,
        countryName = json['CountryName'] as String?,
        countryId = json['CountryId'] as int?,
        userCode = json['UserCode'] as String?,
        areaId = json['AreaId'] as int?,
        email = json['Email'] as String?,
        isCustomer = json['IsCustomer'] as bool?,
        mobileNumber = json['MobileNumber'] as String?,
        areaName = json['AreaName'] as String?,
        cityId = json['CityId'] as int?,
        cityName = json['CityName'] as String?,
        interestedInGlutenFree = json['InterestedInGlutenFree'] as bool?,
        nationalityName = json['NationalityName'] as String?,
        nationality = json['Nationality'] as int?,
        isRider = json['IsRider'] as bool?,
        bikeModelId = json['BikeModelId'] as int?,
        bikeName = json['BikeName'] as String?,
        bikeModelYear = json['BikeModelYear'] as int?,
        isHogMember = json['IsHogMember'] as bool?,
        hogMemberId = json['HogMemberId'] as String?,
        companyName = json['CompanyName'] as String?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    "Id": id,
    'FirstName' : firstName,
    'LastName' : lastName,
    'BirthDate' : birthDate,
    'MeritalStatusType' : meritalStatusType,
    'WifeBirthdate' : wifeBirthdate,
    'AnniversaryDate' : anniversaryDate,
    'GenderType' : genderType,
    'CountryName' : countryName,
    'CountryId' : countryId,
    'UserCode' : userCode,
    'AreaId' : areaId,
    'Email' : email,
    'IsCustomer' : isCustomer,
    'MobileNumber' : mobileNumber,
    'AreaName' : areaName,
    'CityId' : cityId,
    'CityName' : cityName,
    'InterestedInGlutenFree' : interestedInGlutenFree,
    'NationalityName' : nationalityName,
    'Nationality' : nationality,
    'IsRider' : isRider,
    'BikeModelId' : bikeModelId,
    'BikeName' : bikeName,
    'BikeModelYear' : bikeModelYear,
    'IsHogMember' : isHogMember,
    'HogMemberId' : hogMemberId,
    'CompanyName' : companyName,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}


