const String _PATH_MEASUREMENT = 'measurements';
const String _PARAM_GROUP = 'group_id';
const String _PARAM_PROCESS = 'process_id';
const String _PARAM_GRANULARITY = 'granularity';
const String _PARAM_PERIOD = 'period';
const String _PARAM_ST_DATE = 'start';
const String _PARAM_END_DATE = 'end';
const String _PARAM_MEASUREMENT = 'm';

class BaseMeasurementQuery {
  final String param;
  String value;

  BaseMeasurementQuery(this.param, this.value);

  factory BaseMeasurementQuery.fromJson(Map<String, dynamic> json) =>
      BaseMeasurementQuery(json['param'], json['value']);

  Map<String, dynamic> toJson() => {
        'param': param,
        'value': value,
      };
}

class PathProcess extends BaseMeasurementQuery {
  PathProcess(String value) : super(_PARAM_PROCESS, value);
}

class PathGroup extends BaseMeasurementQuery {
  PathGroup(String value) : super(_PARAM_GROUP, value);
}

class PathMeasurement extends BaseMeasurementQuery {
  PathMeasurement(String value) : super(_PATH_MEASUREMENT, value);
}

class ParamGroup extends BaseMeasurementQuery {
  ParamGroup(String value) : super(_PARAM_GROUP, value);
}

class ParamProcess extends BaseMeasurementQuery {
  ParamProcess(String value) : super(_PARAM_PROCESS, value);
}

class ParamGranularity extends BaseMeasurementQuery {
  ParamGranularity(String value) : super(_PARAM_GRANULARITY, value);
}

class ParamPeriod extends BaseMeasurementQuery {
  ParamPeriod(String value) : super(_PARAM_PERIOD, value);
}

class ParamStDate extends BaseMeasurementQuery {
  ParamStDate(String value) : super(_PARAM_ST_DATE, value);
}

class ParamEndDate extends BaseMeasurementQuery {
  ParamEndDate(String value) : super(_PARAM_END_DATE, value);
}

class ParamMeasurement extends BaseMeasurementQuery {
  ParamMeasurement(String value) : super(_PARAM_MEASUREMENT, value);
}
