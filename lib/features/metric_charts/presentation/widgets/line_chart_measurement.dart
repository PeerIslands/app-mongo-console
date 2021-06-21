import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/chart_subtitle.dart';
import 'package:flutter_auth/core/widgets/chart_title.dart';
import 'package:flutter_auth/core/widgets/date_picker_range.dart';
import 'package:flutter_auth/core/widgets/line_chart_thick.dart';
import 'package:flutter_auth/core/widgets/not_found.dart';
import 'package:flutter_auth/core/widgets/start_end_date_range.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_auth/features/metric_charts/presentation/util/measurementToLineChartThickConverter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LineChartMeasurement extends StatefulWidget {
  final String title;
  final String subtitle;

  const LineChartMeasurement({Key key, this.title, this.subtitle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      LineChartMeasurementState(title: title, subtitle: subtitle);
}

class LineChartMeasurementState extends State<LineChartMeasurement> {
  final String title;
  final String subtitle;

  LineChartMeasurementState({this.title, this.subtitle});

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now().subtract(Duration(days: 7));
    endDate = DateTime.now();
  }

  DateTime startDate;
  DateTime endDate;

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
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ChartTitle(title: title),
                      SizedBox(height: 4),
                      ChartSubtitle(subtitle: subtitle),
                      SizedBox(height: 4),
                      StartEndDateRange(startDate: startDate, endDate: endDate),
                      SizedBox(height: 37),
                      _showErrorOrData(state),
                      SizedBox(height: 10),
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
                                    if (startDate != start || end != endDate) {
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
            );
          },
        ),
      ),
    );
  }

  Widget _showErrorOrData(MeasurementState state) {
    if (state is DataLoaded) {
      final arrayOfLines = MeasurementToLineChartThickConverter().convert(state.measurement);

      if (arrayOfLines.isNotEmpty){
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 16.0, left: 6.0),
            child: LineChartThick(arrayOfLines: arrayOfLines, numberOfItems: arrayOfLines[0].length),
          ),
        );
      }
    }

    return NotFound();
  }
}


