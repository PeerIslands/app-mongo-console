import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard.dart';

class DashboardModel extends Dashboard {
  DashboardModel({@required NumAccessModel numAccess, @required NumDBModel numDbUsers})
      : super(numAccess, numDbUsers);

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      numAccess: json['numAccess'] != null
          ? NumAccessModel.fromJson(json['numAccess'])
          : null,
      numDbUsers: json['numDbUsers'] != null
          ? NumDBModel.fromJson(json['numDbUsers'])
          : null);
  }

  Map<String, dynamic> toJson() => {
        'numAccess': this.numAccess != null
            ? (this.numAccess as NumAccessModel).toJson()
            : null,
        'numDbUsers': this.numDbUsers != null
            ? (this.numDbUsers as NumDBModel).toJson()
            : null,
      };
}

class NumAccessModel extends NumAccess {
  NumAccessModel({@required totalCount}) : super(totalCount);

  factory NumAccessModel.fromJson(Map<String, dynamic> json) =>
      NumAccessModel(totalCount: json['TotalCount']);

  Map<String, dynamic> toJson() => {'TotalCount': this.totalCount};
}

class NumDBModel extends NumDB {
  NumDBModel({@required totalCount}) : super(totalCount);

  factory NumDBModel.fromJson(Map<String, dynamic> json) =>
      NumDBModel(totalCount: json['TotalCount']);

  Map<String, dynamic> toJson() => {'TotalCount': this.totalCount};
}
