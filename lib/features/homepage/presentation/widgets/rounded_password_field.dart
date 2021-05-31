import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/colors_constants.dart';
import 'package:flutter_auth/core/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: PRIMARY_COLOR,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: PRIMARY_COLOR,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: PRIMARY_COLOR,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
