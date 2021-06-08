import 'package:equatable/equatable.dart';

import 'share/links.dart';

class Group extends Equatable {
  final int clusterCount;
  final String created;
  final String id;
  final List<Links> links;
  final String name;
  final String orgId;

  Group(this.clusterCount,
        this.created,
        this.id,
        this.links,
        this.name,
        this.orgId);

  @override
  List<Object> get props => [clusterCount, created, id, links, name, orgId];
}