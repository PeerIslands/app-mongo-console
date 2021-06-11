import 'dart:convert';

import 'package:flutter_auth/core/constants/storage_constants.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';

abstract class MeasurementParamsCacheDataSource {
  Future<List<BaseMeasurementQuery>> getParams();

  Future<void> cacheParams(List<BaseMeasurementQuery> processesToCache);

  Future<void> clear();

  Future<bool> checkParamsExists();
}

class MeasurementParamsCacheDataSourceImpl
    implements MeasurementParamsCacheDataSource {
  @override
  Future<List<BaseMeasurementQuery>> getParams() async {
    var paramsJson = jsonDecode(
        await ApiBaseHelper.storage.read(key: CACHE_MEASUREMENT_PARAMS));

    return Future.value((paramsJson as List)
        .map((process) => BaseMeasurementQuery.fromJson(process))
        .toList());
  }

  @override
  Future<void> cacheParams(List<BaseMeasurementQuery> paramsToCache) {
    if (paramsToCache != null && paramsToCache != []) {
      var paramsJson =
          jsonEncode(paramsToCache.map((e) => e.toJson()).toList());

      return Future.value(ApiBaseHelper.storage
          .write(key: CACHE_MEASUREMENT_PARAMS, value: paramsJson));
    }

    return Future.value(true);
  }

  @override
  Future<bool> checkParamsExists() {
    return ApiBaseHelper.storage.containsKey(key: CACHE_MEASUREMENT_PARAMS);
  }

  @override
  Future<void> clear() async {
    await ApiBaseHelper.storage.delete(key: CACHE_MEASUREMENT_PARAMS);
  }
}
