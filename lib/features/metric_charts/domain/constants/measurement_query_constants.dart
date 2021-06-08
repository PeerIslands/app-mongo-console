import 'package:equatable/equatable.dart';

const String _PATH_PROCESS = 'processes';
const String _PATH_GROUP = 'groups';
const String _PATH_MEASUREMENT = 'measurements';
const String _PARAM_GROUP = 'group_id';
const String _PARAM_PROCESS = 'process_id';
const String _PARAM_GRANULARITY = 'granularity';
const String _PARAM_PERIOD = 'period';
const String _PARAM_ST_DATE = 'start';
const String _PARAM_END_DATE = 'end';
const String _PARAM_MEASUREMENT = 'm';

abstract class BaseMeasurementQuery extends Equatable {
  final String param;
  final String value;

  BaseMeasurementQuery(this.param, this.value);
}

class PathProcess extends BaseMeasurementQuery {
  PathProcess(String value) : super(_PARAM_PROCESS, value);

  @override
  List<Object> get props => [param, value];
}

class PathGroup extends BaseMeasurementQuery {
  PathGroup(String value) : super(_PARAM_GROUP, value);

  @override
  List<Object> get props => [param, value];
}

class PathMeasurement extends BaseMeasurementQuery {
  PathMeasurement(String value) : super(_PATH_MEASUREMENT, value);

  @override
  List<Object> get props => [param, value];
}

class ParamGroup extends BaseMeasurementQuery {
  ParamGroup(String value) : super(_PARAM_GROUP, value);

  @override
  List<Object> get props => [param, value];
}

class ParamProcess extends BaseMeasurementQuery {
  ParamProcess(String value) : super(_PARAM_PROCESS, value);

  @override
  List<Object> get props => [param, value];
}

class ParamGranularity extends BaseMeasurementQuery {
  ParamGranularity(String value) : super(_PARAM_GRANULARITY, value);

  @override
  List<Object> get props => [param, value];
}

class ParamPeriod extends BaseMeasurementQuery {
  ParamPeriod(String value) : super(_PARAM_PERIOD, value);

  @override
  List<Object> get props => [param, value];
}

class ParamStDate extends BaseMeasurementQuery {
  ParamStDate(String value) : super(_PARAM_ST_DATE, value);

  @override
  List<Object> get props => [param, value];
}

class ParamEndDate extends BaseMeasurementQuery {
  ParamEndDate(String value) : super(_PARAM_END_DATE, value);

  @override
  List<Object> get props => [param, value];
}

class ParamMeasurement extends BaseMeasurementQuery {
  ParamMeasurement(String value) : super(_PARAM_MEASUREMENT, value);

  @override
  List<Object> get props => [param, value];
}
