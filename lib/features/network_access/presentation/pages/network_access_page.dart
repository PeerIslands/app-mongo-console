import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/load_requests.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/core/widgets/not_found.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_bloc.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_event.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_state.dart';
import 'package:flutter_auth/features/network_access/presentation/widgets/network_request_item.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NetworkAccessPage extends StatefulWidget {
  @override
  _NetworkAccessPageState createState() => _NetworkAccessPageState();
}

class _NetworkAccessPageState extends State<NetworkAccessPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<NetworkAccessBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: handleBackPressed,
          child: Container(
            child: Stack(children: <Widget>[
              Scaffold(
                appBar: AppBarDefault(title: 'Network Access'),
                backgroundColor: primaryColor(context),
                body: StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 50.0,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                  children: <Widget>[
                    BlocConsumer<NetworkAccessBloc, NetworkAccessState>(
                      // ignore: missing_return
                      builder: (context, state) {
                        if (state is Empty) {
                          context
                              .read<NetworkAccessBloc>()
                              .add(GetNetworkAccessRequests());
                        }

                        return _buildDataLoadedOrNotFound(state);
                      },
                      listener: (context, state) {
                        if (state
                            is NetworkAccessErrorWhileApprovingOrDeclining) {
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
                            .read<NetworkAccessBloc>()
                            .add(GetNetworkAccessRequests()))
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
      ),
    );
  }

  Widget _buildDataLoadedOrNotFound(NetworkAccessState state) {
    if (state is NetworkAccessListLoaded &&
        state.networkAccessList.isNotEmpty) {
      return MaterialTile(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var item = state.networkAccessList[index];

              return NetworkRequestItem(item: item, state: state, index: index);
            },
            itemCount: state.networkAccessList.length,
          ),
        ),
      );
    }

    return MaterialTile(child: NotFound());
  }
}
