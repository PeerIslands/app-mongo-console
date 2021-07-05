import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/dropdown_processes.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/bar_chart_thick_measurement.dart';

class ConnectionsChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  appBar: AppBarDefault(title: 'Connections Chart'),
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
                              .add(GetConnectionData());
                        }

                        return MaterialTile(
                            child:
                                BarChartThickMeasurement(title: 'Connections'));
                      })
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(2, 80.0),
                      StaggeredTile.extent(2, 600.0),
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
