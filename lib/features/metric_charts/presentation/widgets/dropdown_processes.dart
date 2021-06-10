import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/widgets/dropdown_item.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownProcesses extends StatefulWidget {
  const DropdownProcesses({
    Key key,
  }) : super(key: key);

  @override
  _DropdownProcessesState createState() => _DropdownProcessesState();
}

class _DropdownProcessesState extends State<DropdownProcesses> {
  MeasurementEvent processEvent;

  dispatchSelectedProcessEvent(BuildContext context, Process process) {
    context.read<MeasurementBloc>().add(ProcessChanged(process: process));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialTile(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
        child: BlocBuilder<ProcessBloc, ProcessState>(
          builder: (context, state) {
            if (state is Empty || state is DataFailed) {
              context.read<ProcessBloc>().add(FetchDataRequested());
            } else if (state is DataLoaded) {
              return DropdownItem(
                mode: Mode.BOTTOM_SHEET,
                title: 'Select an instance',
                items: state.processes.map((process) => process.id).toList(),
                callback: (id) => dispatchSelectedProcessEvent(context,
                    state.processes.firstWhere((element) => element.id == id)),
              );
            }

            return DropdownItem(
              mode: Mode.BOTTOM_SHEET,
              title: 'Select an instance',
            );
          },
        ),
      ),
    );
  }
}
