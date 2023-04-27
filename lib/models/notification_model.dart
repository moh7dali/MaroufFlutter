import 'package:Marouf/models/error_model.dart';

class NotificationModel {
  int? numberofUnreadNotification;
  List<NotificationItemModel>? notificationList;
  bool? isSucceeded;
  List<ErrorModel>? errors;

  NotificationModel({
    this.numberofUnreadNotification,
    this.notificationList,
    this.isSucceeded,
    this.errors,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    numberofUnreadNotification = json['NumberofUnreadNotification'] as int?;
    notificationList = (json['NotificationList'] as List?)
        ?.map(
            (dynamic e) => NotificationItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    isSucceeded = json['IsSucceeded'] as bool?;
    errors = (json['Errors'] as List?)
        ?.map((dynamic e) => ErrorModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['NumberofUnreadNotification'] = numberofUnreadNotification;
    json['NotificationList'] =
        notificationList?.map((e) => e.toJson()).toList();
    json['IsSucceeded'] = isSucceeded;
    json['Errors'] = errors?.map((e) => e.toJson()).toList();
    return json;
  }
}

class NotificationItemModel {
  int? id;
  String? subject;
  String? message;
  int? triggerTypeId;
  int? triggerId;
  bool? isReaded;
  String? creationDate;

  NotificationItemModel({
    this.id,
    this.subject,
    this.message,
    this.triggerTypeId,
    this.triggerId,
    this.isReaded,
    this.creationDate,
  });

  NotificationItemModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'] as int?;
    subject = json['Subject'] as String?;
    message = json['Message'] as String?;
    triggerTypeId = json['TriggerTypeId'] as int?;
    triggerId = json['TriggerId'] as int?;
    isReaded = json['IsReaded'] as bool?;
    creationDate = json['CreationDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Id'] = id;
    json['Subject'] = subject;
    json['Message'] = message;
    json['TriggerTypeId'] = triggerTypeId;
    json['TriggerId'] = triggerId;
    json['IsReaded'] = isReaded;
    json['CreationDate'] = creationDate;
    return json;
  }
}


