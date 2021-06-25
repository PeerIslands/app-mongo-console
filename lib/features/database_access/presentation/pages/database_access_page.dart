import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_bloc.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_event.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_state.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DatabaseAccessPage extends StatefulWidget {
  @override
  _DatabaseAccessPageState createState() => _DatabaseAccessPageState();
}

class _DatabaseAccessPageState extends State<DatabaseAccessPage> {
  final List<HomeModal> items = List.generate(
    3,
        (i) => HomeModal(
      i,
      _position(i),
      _subtitle(i),
      _avatarColor(i),
    ),
  );

  static Color _avatarColor(int index) {
    switch (index % 4) {
      case 0:
        return Colors.cyan[500];
      case 1:
        return Colors.teal;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      default:
        return null;
    }
  }

  static String _subtitle(int index) {
    if (index == 2)
      return '(1 Cluster, 0 Data Lakes)';

    return '(All Resources)';
  }

  static String _position(int index) {
    switch (index % 4) {
      case 0:
        return 'sa';
      case 1:
        return 'gabriel_moreli';
      case 2:
        return 'ganesh';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<DatabaseAccessBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: handleBackPressed,
          child: Container(
            child: Stack(children: <Widget>[
              Scaffold(
                appBar: AppBarDefault(title: 'Database Access'),
                backgroundColor: primaryColor(context),
                body: BlocBuilder<DatabaseAccessBloc, DatabaseAccessState>(
                  // ignore: missing_return
                    builder: (context, state) {
                      if (state is Empty) {
                        context
                            .read<DatabaseAccessBloc>()
                            .add(GetDatabaseAccessRequests());
                      }

                      return StaggeredGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 50.0,
                        padding:
                        EdgeInsets.only(left: 8, right: 8, top: 30, bottom: 8),
                        children: <Widget>[
                          MaterialTile(
                            child: Center(
                              child: OrientationBuilder(
                                builder: (context, orientation) => _buildList(
                                    context,
                                    orientation == Orientation.portrait
                                        ? Axis.vertical
                                        : Axis.horizontal),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    defaultButtonColor(context)),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w700)),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    defaultButtonTextColor(context))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DatabaseAccessPage();
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.refresh, size: 30),
                            label: Text("LOAD REQUESTS"),
                          )
                        ],
                        staggeredTiles: [
                          StaggeredTile.extent(2, 420),
                          StaggeredTile.extent(2, 80.0),
                        ],
                      );
                    }),
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

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
        direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;

        return _slidableWithDelegates(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _slidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    final HomeModal item = items[index];
    return Slidable.builder(
        key: Key(item.titles),
        direction: direction,
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          closeOnCanceled: true,
          onDismissed: (actionType) {
            _showSnackBar(
                context,
                actionType == SlideActionType.primary
                    ? 'Dismiss Archive'
                    : 'Dismiss Delete');
            setState(() {
              items.removeAt(index);
            });
          },
        ),
        actionPane: _actionPane(item.index),
        actionExtentRatio: 0.20,
        child: direction == Axis.horizontal
            ? VerticalList(items[index])
            : HorizontalList(items[index]),
        actionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Decline',
                color: Colors.red,
                icon: Icons.thumb_down,
                onTap: () async {
                  var state = Slidable.of(context);
                  var dismiss = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.redAccent,
                        title: Text(
                          'Decline',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          'IP Address will be declined',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          FlatButton(
                            child: Text(
                              'Ok',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );

                  if (dismiss) {
                    state.dismiss();
                  }
                },
              );
            } else {
              return IconSlideAction(
                caption: 'Accept',
                color: Colors.green,
                icon: Icons.thumb_up,
                onTap: () => _showSnackBar(context, 'Edit'),
              );
            }
          },
        ));
  }

  static Widget _actionPane(int index) {
    return SlidableStrechActionPane();
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class VerticalList extends StatelessWidget {
  VerticalList(this.item);

  final HomeModal item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
          ? Slidable.of(context)?.open()
          : Slidable.of(context)?.close(),
      child: Container(
        decoration:
        BoxDecoration(border: Border.all(width: 0.2, color: Colors.white)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.color,
            child: Icon(
              Icons.supervised_user_circle_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            foregroundColor: Colors.white,
          ),
          title: Text(item.titles),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }
}

class HomeModal {
  const HomeModal(
      this.index,
      this.titles,
      this.subtitle,
      this.color,
      );

  final int index;
  final String titles;
  final String subtitle;
  final Color color;
}

class HorizontalList extends StatelessWidget {
  HorizontalList(this.item);

  final HomeModal item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 90.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
