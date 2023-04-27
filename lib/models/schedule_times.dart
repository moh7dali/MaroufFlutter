
import 'error_model.dart';

class ScheduleTimes {
  final List<DateWithTime>? data;
  final bool? isSucceeded;
  final List<ErrorModel>? errors;

  ScheduleTimes({
    this.data,
    this.isSucceeded,
    this.errors,
  });

  ScheduleTimes.fromJson(Map<String, dynamic> json)
      : data = (json['Data'] as List?)?.map((dynamic e) => DateWithTime.fromJson(e as Map<String,dynamic>)).toList(),
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => ErrorModel.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Data' : data?.map((e) => e.toJson()).toList(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class DateWithTime {
  final String? scheduleDate;
  final List<String>? timesList;

  DateWithTime({
    this.scheduleDate,
    this.timesList,
  });

  DateWithTime.fromJson(Map<String, dynamic> json)
      : scheduleDate = json['ScheduleDate'] as String?,
        timesList = (json['TimesList'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'ScheduleDate' : scheduleDate,
    'TimesList' : timesList
  };
}

