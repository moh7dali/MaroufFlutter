
import 'dart:convert';

MainResponse mainResponseFromJson(String str) => MainResponse.fromJson(json.decode(str));

String mainResponseToJson(MainResponse data) => json.encode(data.toJson());

  class MainResponse {
  MainResponse({
    this.isSucceeded,
    this.errors,
  });

  bool? isSucceeded;
  List<Error>? errors;

  factory MainResponse.fromJson(Map<String, dynamic> json) => MainResponse(
    isSucceeded: json["IsSucceeded"],
    errors: json["Errors"] == null ? null : List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IsSucceeded": isSucceeded,
    "Errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class Error {
  Error({
    this.errorCode,
    this.errorMessage,
  });

  int? errorCode;
  String? errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    errorCode: json["ErrorCode"],
    errorMessage: json["ErrorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorCode": errorCode,
    "ErrorMessage": errorMessage,
  };
}
