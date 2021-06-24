import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'material_tile.dart';

class MultiSelect<T> extends StatefulWidget {
  final List<MultiSelectItem<T>> initialValues;
  final int selectNInitialValues;
  final Function callback;

  const MultiSelect({
    Key key,
    this.initialValues,
    this.callback,
    this.selectNInitialValues,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MultiSelectState<T>(
      initialValues: initialValues,
      selectNInitialValues: selectNInitialValues,
      callback: callback);
}

class MultiSelectState<T> extends State<MultiSelect<T>> {
  final int selectNInitialValues;
  final Function callback;
  final List<MultiSelectItem<T>> initialValues;

  MultiSelectState({
    this.initialValues,
    this.callback,
    this.selectNInitialValues,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialTile(
      child: Padding(
        padding: EdgeInsets.zero,
        child: MultiSelectChipField<T>(
          decoration: BoxDecoration(),
          searchable: true,
          initialValue: selectNInitialValues == null
              ? initialValues.map((e) => e.value).toList()
              : initialValues
                  .take(selectNInitialValues)
                  .map((e) => e.value)
                  .toList(),
          showHeader: false,
          items: initialValues,
          autovalidateMode: AutovalidateMode.always,
          icon: Icon(Icons.check),
          onTap: (values) {
            if (values.isNotEmpty) {
              callback(values);
            }
          },
        ),
      ),
    );
  }
}
