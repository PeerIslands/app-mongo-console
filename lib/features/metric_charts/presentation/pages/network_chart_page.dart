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
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NetworkChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MeasurementType> _initialTypesToShow = [
      MeasurementType.NETWORK_BYTES_IN,
      MeasurementType.NETWORK_BYTES_OUT,
      MeasurementType.NETWORK_NUM_REQUESTS
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<MeasurementBloc>()),
        BlocProvider(create: (_) => injector<ProcessBloc>())
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: handleBackPressed,
          child: Container(
            child: Stack(children: <Widget>[
              Scaffold(
                  appBar: AppBarDefault(title: 'Network Chart'),
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
                          builder: (context, state) {
                        if (state is Empty) {
                          context
                              .read<MeasurementBloc>()
                              .add(GetBytesInBytesOutData());
                        }
                        return Column(
                          children: [
                            MultiSelect<MeasurementType>(
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
                              title: 'Network',
                              subtitle: 'BYTES IN/BYTES OUT/NUM REQUESTS',
                              type: LineChartType.Thick,
                            ))
                          ],
                        );
                      }),
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
