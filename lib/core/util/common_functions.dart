import 'dart:math';
import 'dart:ui';

import 'package:date_format/date_format.dart';

String buildFormatDate(DateTime date) => formatDate(date, [
      dd,
      '/',
      mm,
      '/',
      yyyy,
    ]);

void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
    map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

Color getRandomColor() =>
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

Iterable<int> createRange(double low, double high) sync* {
  int interval = 20;

  if (high < 5) {
    interval = 1;
  }
  if (high < 10) {
    interval = 2;
  } else if (high < 50) {
    interval = 10;
  }

  for (int i = low.round(); i < high; i += interval) {
    yield i;
  }
}
