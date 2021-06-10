import 'dart:convert';

import 'package:flutter_auth/core/constants/storage_constants.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/metric_charts/data/models/process_model.dart';

abstract class ProcessCacheDataSource {
  Future<List<ProcessModel>> getProcesses();

  Future<void> cacheProcesses(List<ProcessModel> processesToCache);

  Future<bool> checkProcessExists();
}

class ProcessCacheDataSourceImpl implements ProcessCacheDataSource {
  @override
  Future<List<ProcessModel>> getProcesses() async {
    var processesJson =
        jsonDecode(await ApiBaseHelper.storage.read(key: CACHE_PROCESS));

    return Future.value((processesJson as List)
        .map((process) => ProcessModel.fromJson(process))
        .toList());
  }

  @override
  Future<void> cacheProcesses(List<ProcessModel> processesToCache) {
    if (processesToCache != null && processesToCache != []) {
      var processesJson =
          jsonEncode(processesToCache.map((e) => e.toJson()).toList());

      return Future.value(ApiBaseHelper.storage
          .write(key: CACHE_PROCESS, value: processesJson));
    }

    return Future.value(true);
  }

  @override
  Future<bool> checkProcessExists() {
    return Future.value(ApiBaseHelper.storage.containsKey(key: CACHE_PROCESS));
  }
}
