import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';

class NetworkAccessModel extends NetworkAccess {
  NetworkAccessModel(
      {@required id,
      @required cidrBlock,
      @required comment,
      @required groupId,
      @required deleteAfterDate,
      @required createdAt,
      @required updatedAt,
      @required createdBy,
      @required status})
      : super(id, cidrBlock, comment, groupId, deleteAfterDate, createdAt,
            updatedAt, createdBy, status);

  factory NetworkAccessModel.fromJson(Map<String, dynamic> json) =>
      NetworkAccessModel(
        id: json['id'],
        cidrBlock: json['cidrBlock'],
        comment: json['comment'],
        groupId: json['groupId'],
        deleteAfterDate: json['deleteAfterDate'],
        createdAt: json['CreatedAt'],
        updatedAt: json['UpdatedAt'],
        createdBy: json['CreatedBy'],
        status: json['Status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cidrBlock': cidrBlock,
        'comment': comment,
        'groupId': groupId,
        'deleteAfterDate': deleteAfterDate,
        'CreatedAt': createdAt,
        'UpdatedAt': updatedAt,
        'CreatedBy': createdBy,
        'Status': status,
      };
}
