import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/core/widgets/bar_chart_thick.dart';
import 'package:flutter_auth/core/widgets/date_picker_range.dart';
import 'package:flutter_auth/core/widgets/not_found.dart';
import 'package:flutter_auth/core/widgets/start_end_date_range.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard_chart.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/dashboard/add_dashboard_chart.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_auth/features/metric_charts/presentation/converters/measurementToBarChartThickConverter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/chart_title.dart';
import 'chart_pinned_or_not.dart';

class BarChartThickMeasurement extends StatefulWidget {
  final String title;
  final Measurement measurement;

  const BarChartThickMeasurement({Key key, this.title, this.measurement})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      BarChartThickMeasurementState(title: title, measurement: measurement);
}

class BarChartThickMeasurementState extends State<BarChartThickMeasurement> {
  final String title;
  Measurement measurement;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  BarChartThickMeasurementState({this.title, this.measurement});

  final AddOrRemoveDashboardChart addOrRemoveDashboardChart =
      injector<AddOrRemoveDashboardChart>();

  _dispatchSelectedDateEvent(BuildContext context) {
    context
        .read<MeasurementBloc>()
        .add(ChangeParams(startDate: startDate, endDate: endDate));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.7,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        color: connectionsChartColor(context),
        child: BlocConsumer<MeasurementBloc, MeasurementState>(
            listener: (BuildContext context, state) {
              if (state is Empty || state is BaseQueryBuilt) {
                _dispatchSelectedDateEvent(context);
              }
            },
            builder: (context, state) => Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ChartTitle(title: title),
                          SizedBox(height: 4),
                          StartEndDateRange(
                              startDate: startDate, endDate: endDate),
                          SizedBox(height: 38),
                          _showErrorOrData(state),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ListTile(
                          trailing: Wrap(
                            spacing: 2, // space between two icons
                            children: <Widget>[
                              _getDateTimeRangeOrNot(context),
                              _getPinnedIconIfData(state)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }

  Widget _getDateTimeRangeOrNot(BuildContext context) {
    // if dash
    if (measurement.isNotNull) {
      return SizedBox();
    }

    return IconButton(
      iconSize: 40,
      icon: Icon(CupertinoIcons.calendar),
      onPressed: () => buildMaterialDatePicker(
          context: context,
          initialDateRange: DateTimeRange(start: startDate, end: endDate),
          callback: (DateTime start, DateTime end) {
            setState(() {
              if (startDate != start || end != endDate) {
                startDate = start;
                endDate = end;
                _dispatchSelectedDateEvent(context);
              }
            });
          },
          limitDays: 7),
    );
  }

  Widget _getPinnedIconIfData(MeasurementState state) {
    if (state is MeasurementDataLoaded) {
      return ChartPinnedOrNot(title: title, data: state.measurement);
    } else {
      return SizedBox();
    }
  }

  Widget _showErrorOrData(MeasurementState state) {
    Measurement measurementData;

    if (measurement.isNotNull) {
      measurementData = measurement;
    } else if (state is MeasurementDataLoaded) {
      addOrRemoveDashboardChart(DashboardChart(
          title: title,
          measurement: state.measurement,
          justRefreshDataIfPinned: true));

      measurementData = state.measurement;
    }

    if (measurementData.isNotNull) {
      final items =
          MeasurementToBarChartThickConverter().convert(measurementData);

      if (items.isNotEmpty) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: BarChartThick(items: items),
          ),
        );
      }
    }

    return NotFound();
  }
}
