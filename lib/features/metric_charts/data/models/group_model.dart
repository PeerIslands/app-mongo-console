import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/group.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/shared/links.dart';

import 'shared/links_model.dart';

class GroupModel extends Group {
  GroupModel(
      {@required int clusterCount,
      @required String created,
      @required String id,
      @required List<Links> links,
      @required String name,
      @required String orgId})
      : super(clusterCount, created, id, links, name, orgId);

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
      clusterCount: json['clusterCount'],
      created: json['created'],
      id: json['id'],
      name: json['name'],
      orgId: json['orgId'],
      links: json['links'] != null
          ? json['links'].forEach((v) {
              new LinksModel.fromJson(v);
            })
          : []);

  Map<String, dynamic> toJson() => {
        'clusterCount': clusterCount,
        'created': created,
        'id': id,
        'name': name,
        'orgId': orgId,
        'links': this.links != null
            ? (links as List<LinksModel>).map((v) => v.toJson()).toList()
            : [],
      };
}
