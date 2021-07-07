import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/line_chart_item.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/core/widgets/multi_select.dart';
import 'package:flutter_auth/features/metric_charts/domain/enums/measurement_type_enum.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/dropdown_processes.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/line_chart_measurement.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class OpcountersChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MeasurementType> _initialTypesToShow = [
      MeasurementType.OPCOUNTER_QUERY,
      MeasurementType.OPCOUNTER_CMD,
      MeasurementType.OPCOUNTER_INSERT,
      MeasurementType.OPCOUNTER_UPDATE,
      MeasurementType.OPCOUNTER_DELETE,
      MeasurementType.OPCOUNTER_GETMORE,
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<MeasurementBloc>()),
        BlocProvider(create: (_) => injector<ProcessBloc>())
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: handleBackPressed,
          child: Container(
            child: Stack(children: <Widget>[
              Scaffold(
                  appBar: AppBarDefault(title: 'Opcounters Chart'),
                  backgroundColor: primaryColor(context),
                  body: StaggeredGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                    children: <Widget>[
                      DropdownProcesses(),
                      BlocBuilder<MeasurementBloc, MeasurementState>(
                          // ignore: missing_return
                          builder: (context, state) {
                        if (state is Empty) {
                          context
                              .read<MeasurementBloc>()
                              .add(GetOpcountersData());
                        }

                        return Column(
                          children: [
                            MultiSelect<MeasurementType>(
                              selectNInitialValues: 2,
                              initialValues: _initialTypesToShow
                                  .map((e) => MultiSelectItem<MeasurementType>(
                                      e, e.description))
                                  .toList(),
                              callback: (List<MeasurementType> values) {
                                if (values.isNotEmpty) {
                                  context.read<MeasurementBloc>().add(
                                      GetBytesInBytesOutData(
                                          queryTypes: values));
                                }
                              },
                            ),
                            SizedBox(height: 12),
                            MaterialTile(
                                child: LineChartMeasurement(
                              title: 'Opcounters',
                              subtitle:
                                  'COMMAND/QUERY/DELETE/INSERT/UPDATE/GETMORE',
                              type: LineChartType.Thin,
                            ))
                          ],
                        );
                      })
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(2, 80.0),
                      StaggeredTile.extent(2, 675.0),
                      StaggeredTile.extent(2, 80.0),
                    ],
                  )),
              BottomMenuPage(),
            ]),
          ),
        ),
      ),
    );
  }
}
