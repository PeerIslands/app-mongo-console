import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

const double minHeight = 80;
const double iconStartSize = 75;
const double iconEndSize = 110;
const double iconStartMarginTop = -15;
const double iconEndMarginTop = 50;
const double iconsVerticalSpacing = 0;
const double iconsHorizontalSpacing = 0;
AnimationController controller;

void doNothing() {
  print('Nothing is happening here (yet)');
}

void toggleBottomMenu() =>
    controller.fling(velocity: isBottomSheetOpen ? -2 : 2);

bool get isBottomSheetOpen => (controller.status == AnimationStatus.completed);

double lerp(double min, double max) => lerpDouble(min, max, controller.value);

double maxHeight (BuildContext context) => MediaQuery.of(context).size.height;

double headerTopMargin (BuildContext context) =>
    lerp(16, 0 + MediaQuery.of(context).padding.top);

double get itemBorderRadius => lerp(8, 15);

double get iconLeftBorderRadius => itemBorderRadius;

double get iconRightBorderRadius => itemBorderRadius;

double get iconSize => lerp(iconStartSize, iconEndSize);

double iconTopMargin(int index, BuildContext context) =>
    lerp(
      iconStartMarginTop,
      iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize),
    ) +
        headerTopMargin(context);

double iconLeftMargin(int index) =>
    lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);