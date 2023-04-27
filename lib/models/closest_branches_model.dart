import 'package:Marouf/models/main_response.dart';

class ClosestBranches {
  final Branches? branches;
  final bool? isSucceeded;
  final List<Error>? errors;

  ClosestBranches({
    this.branches,
    this.isSucceeded,
    this.errors,
  });

  ClosestBranches.fromJson(Map<String, dynamic> json)
      : branches = (json['Branches'] as Map<String,dynamic>?) != null ? Branches.fromJson(json['Branches'] as Map<String,dynamic>) : null,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Branches' : branches?.toJson(),
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList()
  };
}

class Branches {
  final List<ClosestBranch>? withinTheRangeBranches;
  final ClosestBranch? outSideTheRangeBranch;
  final List<ClosestBranch>? allBranches;
  final int? totalNumberofResult;

  Branches({
    this.withinTheRangeBranches,
    this.outSideTheRangeBranch,
    this.allBranches,
    this.totalNumberofResult,
  });

  Branches.fromJson(Map<String, dynamic> json)
      : withinTheRangeBranches = (json['WithinTheRangeBranches'] as List?)?.map((dynamic e) => ClosestBranch.fromJson(e as Map<String,dynamic>)).toList(),
        outSideTheRangeBranch = (json['OutSideTheRangeBranch'] as Map<String,dynamic>?) != null ? ClosestBranch.fromJson(json['OutSideTheRangeBranch'] as Map<String,dynamic>) : null,
        allBranches = (json['AllBranches'] as List?)?.map((dynamic e) => ClosestBranch.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberofResult = json['TotalNumberofResult'] as int?;

  Map<String, dynamic> toJson() => {
    'WithinTheRangeBranches' : withinTheRangeBranches?.map((e) => e.toJson()).toList(),
    'OutSideTheRangeBranch' : outSideTheRangeBranch?.toJson(),
    'AllBranches' : allBranches?.map((e) => e.toJson()).toList(),
    'TotalNumberofResult' : totalNumberofResult
  };
}

class ClosestBranch {
  final int? id;
  final String? name;

  ClosestBranch({
    this.id,
    this.name,
  });

  ClosestBranch.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name
  };
}
