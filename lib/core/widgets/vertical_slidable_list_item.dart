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
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: item.showIcon
              ? CircleAvatar(
                  backgroundColor: itemColor,
                  child: _getIconOrText(),
                  foregroundColor: Colors.white,
                )
              : null,
          title: Text(item.title),
          subtitle: item.subtitle.isNotNull && item.subtitle.isNotEmpty
              ? Text(item.subtitle)
              : null,
        ),
      ),
    );
  }

  Widget _getIconOrText() {
    if (item.icon.isNotNull) {
      return Icon(
        item.icon,
        color: Colors.white,
        size: 30.0,
      );
    }

    return Text('${item.title.substring(0, 2).toUpperCase()}');
  }
}
