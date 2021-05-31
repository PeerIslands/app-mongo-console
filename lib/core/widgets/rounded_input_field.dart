import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/colors_constants.dart';
import 'package:flutter_auth/core/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: PRIMARY_COLOR,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: PRIMARY_COLOR,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
