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
  final int interval = high > 50 ? 20 : 10;

  for (int i = low.round(); i < high; i += interval) {
    yield i;
  }
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

extension ListNumExtension<T extends num> on List<T> {
  T get getMin => this.reduce((curr, next) => curr < next ? curr : next);

  T get getMax => this.reduce((curr, next) => curr > next ? curr : next);
}

extension ListListDoubleExtension<T extends num> on List<List<T>> {
  num get getMinBetweenLists {
    var minValue = this[0].getMin;
    this.forEach((element) {
      var auxMin = element.getMin;

      if (auxMin < minValue) {
        minValue = auxMin;
      }
    });

    return minValue;
  }

  num get getMaxBetweenLists {
    var maxValue = this[0].getMax;
    this.forEach((element) {
      var auxMax = element.getMax;

      if (auxMax > maxValue) {
        maxValue = auxMax;
      }
    });

    return maxValue;
  }
}
