import 'package:flutter/material.dart';

class GeneralColors {
  static const black = Color(0xFF070707);
  static const white = Color(0xFFFFFFFF);
  static const lightGreen = Colors.lightGreen;
  static const blue = Colors.blue;
  static const teal = Colors.teal;
  static const amber = Colors.amber;
}

class _ColorsBright {
  static const primary = Colors.lightGreen;
  static const menuPrimary = Color.fromRGBO(73, 82, 85, 1.0);
  static const menuItem = Color(0xFFFFFFFF);
  static const menuItemTile = Color(0xFF070707);
  static const loginPrimary = Color(0xFF648637);
  static const loginSecondary = Color(0xFF495F32);
  static const loginCard = Color(0xFFFFFFFF);
  static const loginBody = Color.fromRGBO(108, 115, 118, 1.0);
  static const loginInputs = Color.fromRGBO(231, 231, 231, 1.0);
  static const dashboardTiles = GeneralColors.white;
  static const dashboardTilesText = GeneralColors.black;
  static const dashboardFirstTileCardIcon = GeneralColors.blue;
  static const dashboardSecondTileCardIcon = Color.fromRGBO(73, 82, 85, 1.0);
  static const dashboardThirdTileCardIcon = GeneralColors.teal;
  static const dashboardForthTileCardIcon = GeneralColors.amber;
  static const dashboardTilesIcon = GeneralColors.white;
}

class _ColorsDark {
  static const primary = _materialDarkPrimary;
  static const menuPrimary = Color.fromRGBO(108, 115, 118, 1.0);
  static const menuItem = Color(0xFFFFFFFF);
  static const menuItemTile = Color(0xFF070707);
  static const loginPrimary = Color.fromRGBO(127, 125, 125, 1.0);
  static const loginSecondary = Color(0xFF1F1F1F);
  static const loginCard = Color.fromRGBO(61, 60, 60, 1.0);
  static const loginBody = Color.fromRGBO(108, 115, 118, 1.0);
  static const loginInputs = Color.fromRGBO(231, 231, 231, 1.0);
  static const dashboardTiles = GeneralColors.black;
  static const dashboardTilesText = GeneralColors.white;
  static const dashboardFirstTileCardIcon = GeneralColors.blue;
  static const dashboardSecondTileCardIcon = Color.fromRGBO(73, 82, 85, 1.0);
  static const dashboardThirdTileCardIcon = GeneralColors.teal;
  static const dashboardForthTileCardIcon = GeneralColors.amber;
  static const dashboardTilesIcon = GeneralColors.white;

  static const _materialDarkPrimary = MaterialColor(
    0xFF2F2C2C,
    const <int, Color>{
      50: const Color(0xFF2F2C2C),
      100: const Color(0xFF2F2C2C),
      200: const Color(0xFF2F2C2C),
      300: const Color(0xFF2F2C2C),
      400: const Color(0xFF2F2C2C),
      500: const Color(0xFF2F2C2C),
      600: const Color(0xFF2F2C2C),
      700: const Color(0xFF2F2C2C),
      800: const Color(0xFF2F2C2C),
      900: const Color(0xFF2F2C2C),
    },
  );
}

bool isThemeCurrentlyDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}

Color invertColorsLightToDark(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return GeneralColors.black;
  } else {
    return GeneralColors.white;
  }
}

Color invertColorsDarkToLight(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return GeneralColors.white;
  } else {
    return GeneralColors.black;
  }
}

Color primaryColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.primary;
  } else {
    return _ColorsBright.primary;
  }
}

Color menuPrimaryColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.menuPrimary;
  } else {
    return _ColorsBright.menuPrimary;
  }
}

Color menuItemColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.menuItem;
  } else {
    return _ColorsBright.menuItem;
  }
}

Color menuItemTileColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.menuItemTile;
  } else {
    return _ColorsBright.menuItemTile;
  }
}

Color loginPrimaryColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.loginPrimary;
  } else {
    return _ColorsBright.loginPrimary;
  }
}

Color loginSecondaryColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.loginSecondary;
  } else {
    return _ColorsBright.loginSecondary;
  }
}

Color loginCardColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.loginCard;
  } else {
    return _ColorsBright.loginCard;
  }
}

Color loginBodyColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.loginBody;
  } else {
    return _ColorsBright.loginBody;
  }
}

Color loginInputsColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.loginInputs;
  } else {
    return _ColorsBright.loginInputs;
  }
}

Color dashboardTilesColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardTiles;
  } else {
    return _ColorsBright.dashboardTiles;
  }
}

Color dashboardTilesTextColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardTilesText;
  } else {
    return _ColorsBright.dashboardTilesText;
  }
}

Color dashboardFirstTileCardIconColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardFirstTileCardIcon;
  } else {
    return _ColorsBright.dashboardFirstTileCardIcon;
  }
}

Color dashboardSecondTileCardIconColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardSecondTileCardIcon;
  } else {
    return _ColorsBright.dashboardSecondTileCardIcon;
  }
}

Color dashboardThirdTileCardIconColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardThirdTileCardIcon;
  } else {
    return _ColorsBright.dashboardThirdTileCardIcon;
  }
}

Color dashboardForthTileCardIconColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardForthTileCardIcon;
  } else {
    return _ColorsBright.dashboardForthTileCardIcon;
  }
}

Color dashboardTilesIconColor(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return _ColorsDark.dashboardTilesIcon;
  } else {
    return _ColorsBright.dashboardTilesIcon;
  }
}
