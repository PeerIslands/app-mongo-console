import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/metric_charts/data/models/group_model.dart';
import 'package:flutter_auth/features/metric_charts/data/models/measurement_model.dart';
import 'package:flutter_auth/features/metric_charts/data/models/process_model.dart';
import 'package:flutter_auth/features/metric_charts/domain/constants/measurement_query_constants.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/group.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {

  @override
  Future<Either<Failure, Measurement>> fetchMeasurements(List<BaseMeasurementQuery> params) async {
    try {
      Map<String, String> queryParams = {};

      params.forEach((element) {
        queryParams[element.param] = element.value;
      });

      Response response = await ApiBaseHelper().get('mongodb/process/measurements', queryParams);

      if (response.statusCode == 200) {
        return Right(MeasurementModel.fromJson(json.decode(response.data)));
      } else {
        return throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Group>> getGroup() async {
    try {
      Response response = await ApiBaseHelper().get('mongodb/groups', {});

      if (response.statusCode == 200) {
        return Right((response.data as List)
            .map((group) => GroupModel.fromJson(group)).toList()[0]);
      } else {
        return throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Process>>> getProcesses(String groupId) async {
    try {
      Map<String, String> queryParams = {
        'group_id': groupId
      };

      Response response = await ApiBaseHelper().get('mongodb/process', queryParams);

      if (response.statusCode == 200) {
        return Right((response.data as List)
            .map((process) => ProcessModel.fromJson(process))
            .toList());
      } else {
        return throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}