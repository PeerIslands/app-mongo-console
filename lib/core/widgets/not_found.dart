import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/image_constants.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var path = isThemeCurrentlyDark(context) ? NOT_FOUND_ERROR_WHITE : NOT_FOUND_ERROR_BLACK;
    var shadow = isThemeCurrentlyDark(context) ? GeneralColors.white : GeneralColors.black;

    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        // Vertically center the widget inside the column
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Opacity(child: Image.asset(path, color: shadow), opacity: 0.5),
            ClipRect(child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Image.asset(path)))
          ]),
        ],
      ),
    );
  }
}
