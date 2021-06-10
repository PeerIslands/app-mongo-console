import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';

import 'shared/links_model.dart';

class ProcessModel extends Process {
  ProcessModel(
      {@required created,
      @required groupId,
      @required hostname,
      @required id,
      @required lastPing,
      @required links,
      @required port,
      @required replicaSetName,
      @required typeName,
      @required userAlias,
      @required version})
      : super(created, groupId, hostname, id, lastPing, links, port,
            replicaSetName, typeName, userAlias, version);

  factory ProcessModel.fromJson(Map<String, dynamic> json) => ProcessModel(
      created: json['created'],
      groupId: json['groupId'],
      hostname: json['hostname'],
      id: json['id'],
      lastPing: json['lastPing'],
      port: json['port'],
      replicaSetName: json['replicaSetName'],
      typeName: json['typeName'],
      userAlias: json['userAlias'],
      version: json['version'],
      links: json['links'] != null
          ? json['links'].forEach((v) {
              new LinksModel.fromJson(v);
            })
          : []);

  Map<String, dynamic> toJson() => {
        'created': created,
        'groupId': groupId,
        'hostname': hostname,
        'id': id,
        'lastPing': lastPing,
        'port': port,
        'replicaSetName': replicaSetName,
        'typeName': typeName,
        'userAlias': userAlias,
        'version': version,
        'links': this.links != null
            ? (links as List<LinksModel>).map((v) => v.toJson()).toList()
            : [],
      };
}
