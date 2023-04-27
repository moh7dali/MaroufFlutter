class CityAreas {
  final List<AreaModel>? areasList;
  final bool? isSucceeded;
  final List<Errors>? errors;

  CityAreas({
    this.areasList,
    this.isSucceeded,
    this.errors,
  });

  CityAreas.fromJson(Map<String, dynamic> json)
      : areasList = (json['AreasList'] as List?)?.map((dynamic e) => AreaModel.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'AreasList' : areasList?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class AreaModel {
  final int? id;
  final String? name;
  final bool? hasSubArea;

  AreaModel({
    this.id,
    this.name,
    this.hasSubArea,
  });

  AreaModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        hasSubArea = json['HasSubArea'] as bool?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'HasSubArea' : hasSubArea
  };
}

class Errors {
  final int? errorCode;
  final String? errorMessage;

  Errors({
    this.errorCode,
    this.errorMessage,
  });

  Errors.fromJson(Map<String, dynamic> json)
      : errorCode = json['ErrorCode'] as int?,
        errorMessage = json['ErrorMessage'] as String?;

  Map<String, dynamic> toJson() => {
    'ErrorCode' : errorCode,
    'ErrorMessage' : errorMessage
  };
}