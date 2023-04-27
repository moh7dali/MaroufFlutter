
class TradeMarkModel {
  List<Trademarks>? trademarks;
  bool? isSucceeded;
  List<Errors>? errors;
  int? totalNumberofResult;

  TradeMarkModel({this.trademarks, this.isSucceeded, this.errors,this.totalNumberofResult});

  TradeMarkModel.fromJson(Map<String, dynamic> json) {
    if(json["Trademarks"] is List) {
      trademarks = json["Trademarks"] == null ? null : (json["Trademarks"] as List).map((e) => Trademarks.fromJson(e)).toList();
    }
    if(json["TotalNumberofResult"] is int) {
      totalNumberofResult = json["TotalNumberofResult"];
    }
    if(json["IsSucceeded"] is bool) {
      isSucceeded = json["IsSucceeded"];
    }
    if(json["Errors"] is List) {
      errors = json["Errors"] == null ? null : (json["Errors"] as List).map((e) => Errors.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(trademarks != null) {
      _data["Trademarks"] = trademarks?.map((e) => e.toJson()).toList();
    }
    _data["TotalNumberofResult"] = totalNumberofResult;
    _data["IsSucceeded"] = isSucceeded;
    if(errors != null) {
      _data["Errors"] = errors?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Errors {
  int? errorCode;
  String? errorMessage;

  Errors({this.errorCode, this.errorMessage});

  Errors.fromJson(Map<String, dynamic> json) {
    if(json["ErrorCode"] is int) {
      errorCode = json["ErrorCode"];
    }
    if(json["ErrorMessage"] is String) {
      errorMessage = json["ErrorMessage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ErrorCode"] = errorCode;
    _data["ErrorMessage"] = errorMessage;
    return _data;
  }
}

class Trademarks {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  Trademarks({this.id, this.name, this.imageUrl, this.description});

  Trademarks.fromJson(Map<String, dynamic> json) {
    if(json["Id"] is int) {
      id = json["Id"];
    }
    if(json["Name"] is String) {
      name = json["Name"];
    }
    if(json["ImageURL"] is String) {
      imageUrl = json["ImageURL"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["Name"] = name;
    _data["ImageURL"] = imageUrl;
    _data["Description"] = description;
    return _data;
  }
}