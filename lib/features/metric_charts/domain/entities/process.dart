import 'package:equatable/equatable.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/share/links.dart';

class Process extends Equatable {
  final String created;
  final String groupId;
  final String hostname;
  final String id;
  final String lastPing;
  final List<Links> links;
  final int port;
  final String replicaSetName;
  final String typeName;
  final String userAlias;
  final String version;

  Process(this.created,
        this.groupId,
        this.hostname,
        this.id,
        this.lastPing,
        this.links,
        this.port,
        this.replicaSetName,
        this.typeName,
        this.userAlias,
        this.version);

  @override
  List<Object> get props => [created, groupId, hostname, id, lastPing, links, port, replicaSetName, typeName, userAlias, version];
}