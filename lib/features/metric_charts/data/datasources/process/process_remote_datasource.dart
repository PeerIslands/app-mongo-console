import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/metric_charts/data/models/process_model.dart';

abstract class ProcessRemoteDataSource {
  Future<List<ProcessModel>> getProcesses(String groupId);
}

class ProcessRemoteDataSourceImpl implements ProcessRemoteDataSource {
  @override
  Future<List<ProcessModel>> getProcesses(String groupId) async {
    Map<String, String> queryParams = {'group_id': groupId};

    Response response = await ApiBaseHelper().get(PROCESSES, queryParams);

    return (response.data as List)
        .map((process) => ProcessModel.fromJson(process))
        .toList();
  }
}
