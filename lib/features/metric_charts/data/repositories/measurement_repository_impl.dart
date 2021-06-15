import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/error/exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/metric_charts/data/datasources/measurement_params_cache_datasource.dart';
import 'package:flutter_auth/features/metric_charts/data/datasources/process/process_cache_datasource.dart';
import 'package:flutter_auth/features/metric_charts/data/datasources/process/process_remote_datasource.dart';
import 'package:flutter_auth/features/metric_charts/data/models/group_model.dart';
import 'package:flutter_auth/features/metric_charts/data/models/measurement_model.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/group.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  final ProcessCacheDataSource processCacheDataSource;
  final ProcessRemoteDataSource processRemoteDataSource;
  final MeasurementParamsCacheDataSource measurementParamsCacheDataSource;

  MeasurementRepositoryImpl(
      {@required this.processCacheDataSource,
      @required this.processRemoteDataSource,
      @required this.measurementParamsCacheDataSource});

  @override
  Future<Either<Failure, Measurement>> fetchMeasurements(
      List<BaseMeasurementQuery> params) async {
    try {
      Map<String, String> queryParams = {};

      params.forEach((element) {
        queryParams[element.param] = element.value;
      });

      Response response = await ApiBaseHelper()
          .get('mongodb/process/measurements', queryParams);

      if (response.statusCode == 200) {
        return Right(MeasurementModel.fromJson(response.data));
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
            .map((group) => GroupModel.fromJson(group))
            .toList()[0]);
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
      if (await processCacheDataSource.checkProcessExists()) {
        return Right(await processCacheDataSource.getProcesses());
      }

      var processes = await processRemoteDataSource.getProcesses(groupId);

      await processCacheDataSource.cacheProcesses(processes);

      return Right(processes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BaseMeasurementQuery>>> getParams(
      List<BaseMeasurementQuery> params) async {
    try {
      if (await measurementParamsCacheDataSource.checkParamsExists()) {
        return Right(await measurementParamsCacheDataSource.getParams());
      }

      throw ServerException();
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> saveParams(List<BaseMeasurementQuery> params) async {
    await measurementParamsCacheDataSource.cacheParams(params);
  }

  @override
  Future<void> clearParams() async {
    await measurementParamsCacheDataSource.clear();
  }
}
