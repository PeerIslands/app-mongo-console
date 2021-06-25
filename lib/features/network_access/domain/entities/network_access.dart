import 'package:equatable/equatable.dart';

class NetworkAccess extends Equatable {
  final String id;
  final String cidrBlock;
  final String comment;
  final String groupId;
  final String deleteAfterDate;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String status;

  NetworkAccess(
      this.id,
      this.cidrBlock,
      this.comment,
      this.groupId,
      this.deleteAfterDate,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.status);

  @override
  List<Object> get props => [
        id,
        cidrBlock,
        comment,
        groupId,
        deleteAfterDate,
        createdAt,
        updatedAt,
        createdBy,
        status
      ];
}
