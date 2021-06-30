import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/entities/slidable_on_tap_options.dart';
import 'package:flutter_auth/core/widgets/vertical_slidable_list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWithDelegates extends StatelessWidget {
  const SlidableWithDelegates({
    Key key,
    @required this.context,
    @required this.item,
    @required this.options,
    @required this.callback,
  }) : super(key: key);

  final BuildContext context;
  final SlidableModal item;
  final List<SlidableOnTapOptions> options;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Slidable.builder(
      key: Key(item.id),
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
      ),
      actionPane: SlidableScrollActionPane(),
      child: VerticalSlidableListItem(item),
      actionDelegate: SlideActionBuilderDelegate(
        actionCount: 2,
        builder: (context, index, animation, renderingMode) {
          var option = options[index];

          return IconSlideAction(
            foregroundColor: Colors.white,
            caption: option.caption,
            color: option.color,
            icon: option.icon,
            onTap: () async {
              var dismiss = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: option.color,
                    content: Text(
                      option.dialogText,
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
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
                callback(option.value);
              }
            },
          );
        },
      ),
    );
  }
}
