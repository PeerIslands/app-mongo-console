import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/util/common_functions.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VerticalSlidableListItem extends StatelessWidget {
  VerticalSlidableListItem(this.item);

  final SlidableModal item;
  final itemColor = getRandomColor();

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
            backgroundColor: itemColor,
            child: _getIconOrText(),
            foregroundColor: Colors.white,
          ),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }

  Widget _getIconOrText() {
    if (item.icon.isNotNull) {
      return Icon(
        Icons.supervised_user_circle_outlined,
        color: Colors.white,
        size: 30.0,
      );
    }

    return Text('${item.title.substring(0, 2).toUpperCase()}');
  }
}
