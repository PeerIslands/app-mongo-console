import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/enums/measurement_type_enum.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';

@immutable
abstract class MeasurementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClearParams extends MeasurementEvent {}

class ChangeParams extends MeasurementEvent {
  final Process process;
  final String granularity;
  final List<MeasurementType> types;
  final DateTime startDate;
  final DateTime endDate;
  final bool isBaseQuery;

  ChangeParams(
      {this.process,
      this.types,
      this.startDate,
      this.endDate,
      this.granularity,
      this.isBaseQuery = false});

  Iterable<BaseMeasurementQuery> buildMeasurementQuery() sync* {
    if (types.isNotNull && types.isNotEmpty) {
      for(var type in types) {
        yield ParamMeasurement(EnumToString.convertToString(type));
      }
    }

    if (process.isNotNull) {
      yield PathGroup(process.groupId);
      yield PathProcess(process.id);
    }

    if (startDate.isNotNull) yield ParamStDate("${startDate.toIso8601String()}Z");
    if (endDate.isNotNull) yield ParamEndDate("${endDate.toIso8601String()}Z");
    if (granularity.isNotNull) yield ParamGranularity('P1D');
  }

  @override
  List<Object> get props => [process, startDate, endDate];
}

class GetMeasurementMetricData extends MeasurementEvent {
  final List<MeasurementType> queryTypes;

  GetMeasurementMetricData({this.queryTypes});

  @override
  List<Object> get props => [queryTypes];
}

class GetConnectionData extends GetMeasurementMetricData {
  GetConnectionData() : super(queryTypes: [MeasurementType.CONNECTIONS]);
}

class GetBytesInBytesOutData extends GetMeasurementMetricData {
  GetBytesInBytesOutData()
      : super(queryTypes: [
          MeasurementType.NETWORK_BYTES_IN,
          MeasurementType.NETWORK_BYTES_OUT,
          MeasurementType.NETWORK_NUM_REQUESTS
        ]);
}

class GetOpcountersData extends GetMeasurementMetricData {
  GetOpcountersData()
      : super(queryTypes: [
          MeasurementType.OPCOUNTER_CMD,
          MeasurementType.OPCOUNTER_QUERY
        ]);
}

class GetLogicalSizeData extends GetMeasurementMetricData {
  GetLogicalSizeData() : super(queryTypes: [MeasurementType.LOGICAL_SIZE]);
}
