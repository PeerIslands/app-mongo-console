import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/core/widgets/load_requests.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/core/widgets/not_found.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_bloc.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_event.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_state.dart';
import 'package:flutter_auth/features/database_access/presentation/widgets/database_request_item.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DatabaseAccessPage extends StatefulWidget {
  @override
  _DatabaseAccessPageState createState() => _DatabaseAccessPageState();
}

class _DatabaseAccessPageState extends State<DatabaseAccessPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<DatabaseAccessBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: handleBackPressed,
          child: Container(
            child: Stack(children: <Widget>[
              Scaffold(
                appBar: AppBarDefault(title: 'Database Access'),
                backgroundColor: primaryColor(context),
                body: StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 50.0,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                  children: <Widget>[
                    BlocConsumer<DatabaseAccessBloc, DatabaseAccessState>(
                      // ignore: missing_return
                      builder: (context, state) {
                        if (state is Empty) {
                          context
                              .read<DatabaseAccessBloc>()
                              .add(GetDatabaseAccessRequests());
                        }

                        return _buildDataLoadedOrNotFound(state);
                      },
                      listener: (context, state) {
                        if (state
                            is DatabaseAccessErrorWhileApprovingOrDeclining) {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: state.message,
                          );
                        }
                      },
                    ),
                    LoadRequests(
                        callback: (BuildContext context) => context
                            .read<DatabaseAccessBloc>()
                            .add(GetDatabaseAccessRequests()))
                  ],
                  staggeredTiles: [
                    StaggeredTile.extent(2, 580),
                    StaggeredTile.extent(2, 80),
                  ],
                ),
              ),
              BottomMenuPage(),
            ]),
          ),
        ),
        floatingActionButton: FloatingDarkLightModeButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }

  Widget _buildDataLoadedOrNotFound(DatabaseAccessState state) {
    if (state is DatabaseAccessListLoaded &&
        state.databaseAccessList.isNotEmpty) {
      return MaterialTile(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var item = state.databaseAccessList[index];

              return DatabaseRequestItem(
                  item: item, state: state, index: index);
            },
            itemCount: state.databaseAccessList.length,
          ),
        ),
      );
    }

    return MaterialTile(child: NotFound());
  }
}
