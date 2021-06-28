import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/dio_exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/core/util/common_functions.dart';
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
      final queryParams = <String, List<String>>{};

      params.forEach((element) {
        addValueToMap(queryParams, element.param, element.value);
      });

      Response response = await ApiBaseHelper().get(MEASUREMENTS, queryParams);

      return Right(MeasurementModel.fromJson(response.data));
    } on ServerException {
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Group>> getGroup() async {
    try {
      Response response = await ApiBaseHelper().get(GROUPS, {});

      return Right((response.data as List)
          .map((group) => GroupModel.fromJson(group))
          .toList()[0]);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Process>>> getProcesses(String groupId) async {
    try {
      var processes = await processRemoteDataSource.getProcesses(groupId);

      await processCacheDataSource.cacheProcesses(processes);

      return Right(processes);
    } on ServerException {
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
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
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
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
