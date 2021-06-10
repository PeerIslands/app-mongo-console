import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';

class DropdownItem extends StatelessWidget {
  final Mode mode;
  final List<String> items;
  final String title;
  final Function callback;

  const DropdownItem({
    Key key,
    @required this.mode,
    @required this.title,
    this.items,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
        mode: mode,
        showSelectedItem: true,
        items: items,
        label: title ?? 'Select an item',
        onChanged: callback);
  }
}
