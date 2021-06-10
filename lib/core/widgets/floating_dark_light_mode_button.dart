import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class FloatingDarkLightModeButton extends StatelessWidget {
  const FloatingDarkLightModeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab',
      child: isThemeCurrentlyDark(context)
          ? Icon(
              EvaIcons.sun,
              size: 30.0,
            ) //show sun icon when in dark mode
          : Icon(
              EvaIcons.moon,
              size: 26.0,
            ),
      //show moon icon when in light mode
      tooltip: isThemeCurrentlyDark(context)
          ? 'Switch to light mode'
          : 'Switch to dark mode',
      foregroundColor: invertColorsLightToDark(context),
      backgroundColor: invertColorsDarkToLight(context),
      elevation: 7.0,
      onPressed: () => EasyDynamicTheme.of(context).changeTheme(),
    );
  }
}
