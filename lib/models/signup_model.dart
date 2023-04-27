import 'dart:convert';

import 'package:Marouf/models/error_model.dart';

SignupModel apiResponseFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String apiResponseToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  dynamic data;
  bool? isSucceeded;
  List<ErrorModel>? errors;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        data: json["Data"],
        isSucceeded: json["IsSucceeded"],
        errors: json["Errors"] == null
            ? null
            : List<ErrorModel>.from(
                json["Errors"].map((x) => ErrorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": data,
        "IsSucceeded": isSucceeded,
          "Errors": errors == null
              ? null
              : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}
