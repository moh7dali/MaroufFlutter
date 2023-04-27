import 'main_response.dart';

class AppVersion {
  final String? versionNumber;
  final String? reasonForStoppingOrder;
  final bool? forceUpdate;
  final bool? canRecieveOrder;
  final String? lastDateToUpdate;
  final bool? isSucceeded;
  final List<Error>? errors;

  AppVersion({
    this.versionNumber,
    this.reasonForStoppingOrder,
    this.forceUpdate,
    this.canRecieveOrder,
    this.lastDateToUpdate,
    this.isSucceeded,
    this.errors,
  });

  AppVersion.fromJson(Map<String, dynamic> json)
      : versionNumber = json['VersionNumber'] as String?,
        reasonForStoppingOrder = json['ReasonForStoppingOrder'] as String?,
        forceUpdate = json['ForceUpdate'] as bool?,
        canRecieveOrder = json['CanRecieveOrder'] as bool?,
        lastDateToUpdate = json['LastDateToUpdate'] as String?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'VersionNumber' : versionNumber,
    'ReasonForStoppingOrder' : reasonForStoppingOrder,
    'ForceUpdate' : forceUpdate,
    'CanRecieveOrder' : canRecieveOrder,
    'LastDateToUpdate' : lastDateToUpdate,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}
