import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_event.dart'
    as ProcessEventClass;
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_state.dart'
    as ProcessStateClass;
import 'package:flutter_auth/features/metric_charts/presentation/widgets/bar_chart_item_thin.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OpcountersChartPage extends StatelessWidget {
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
                  appBar: AppBarDefault(title: 'Opcounters Chart'),
                  backgroundColor: primaryColor(context),
                  body: StaggeredGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                    children: <Widget>[
                      MaterialTile(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
                            child: BlocBuilder<ProcessBloc,
                                    ProcessStateClass.ProcessState>(
                                builder: (context, state) {
                              if (state is ProcessStateClass.Empty) {
                                context.read<ProcessBloc>().add(
                                    ProcessEventClass.FetchDataRequested());

                                return DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    showSelectedItem: true,
                                    items: [],
                                    label: "Select the instance",
                                    onChanged: print);
                              } else if (state
                                  is ProcessStateClass.DataFailed) {
                                return DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    showSelectedItem: true,
                                    items: [],
                                    label: "Select the instance",
                                    onChanged: print);
                              } else if (state
                                  is ProcessStateClass.DataLoaded) {
                                return DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    showSelectedItem: true,
                                    items: state.processes
                                        .map((e) => e.id)
                                        .toList(),
                                    label: "Select the instance",
                                    onChanged: print);
                              }
                              return DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  showSelectedItem: true,
                                  items: [
                                    "cluster0-shard-00-00.wxkgt.mongodb.net:27017",
                                    "cluster0-shard-00-01.wxkgt.mongodb.net:27017",
                                    "cluster0-shard-00-02.wxkgt.mongodb.net:27017"
                                  ],
                                  label: "Select the instance",
                                  onChanged: print,
                                  selectedItem:
                                      "cluster0-shard-00-00.wxkgt.mongodb.net:27017");
                            })),
                      ),
                      MaterialTile(child: BarChartItemThin())
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
        floatingActionButton: FloatingDarkLightModeButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}
