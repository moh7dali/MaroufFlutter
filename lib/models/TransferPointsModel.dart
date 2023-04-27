class TransferPointsModel {
  bool? isSucceeded;
  List<Errors>? errors;

  TransferPointsModel({
    this.isSucceeded,
    this.errors,
  });

  TransferPointsModel.fromJson(Map<String, dynamic> json) {
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['IsSucceeded'] = isSucceeded;
    json['Errors'] = errors?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Errors {
  int? errorCode;
  String? errorMessage;

  Errors({
    this.errorCode,
    this.errorMessage,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'] as int?;
    errorMessage = json['ErrorMessage'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ErrorCode'] = errorCode;
    json['ErrorMessage'] = errorMessage;
    return json;
  }
}