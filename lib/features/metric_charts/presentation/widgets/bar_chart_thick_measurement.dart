import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/bar_chart_thick.dart';
import 'package:flutter_auth/core/widgets/date_picker_range.dart';
import 'package:flutter_auth/core/widgets/not_found.dart';
import 'package:flutter_auth/core/widgets/start_end_date_range.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_auth/features/metric_charts/presentation/util/measurementToBarChartThickConverter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/chart_title.dart';

class BarChartThickMeasurement extends StatefulWidget {
  final String title;

  const BarChartThickMeasurement({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      BarChartThickMeasurementState(title: title);
}

class BarChartThickMeasurementState extends State<BarChartThickMeasurement> {
  final String title;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  BarChartThickMeasurementState({this.title});

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
                              IconButton(
                                iconSize: 40,
                                icon: Icon(CupertinoIcons.calendar),
                                onPressed: () => buildMaterialDatePicker(
                                    context: context,
                                    initialDateRange: DateTimeRange(
                                        start: startDate, end: endDate),
                                    callback: (DateTime start, DateTime end) {
                                      setState(() {
                                        if (startDate != start ||
                                            end != endDate) {
                                          startDate = start;
                                          endDate = end;
                                          _dispatchSelectedDateEvent(context);
                                        }
                                      });
                                    },
                                    limitDays: 7),
                              )
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

  Widget _showErrorOrData(MeasurementState state) {
    if (state is DataLoaded) {
      final items =
          MeasurementToBarChartThickConverter().convert(state.measurement);

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
