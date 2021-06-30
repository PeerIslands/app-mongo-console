extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

extension StringExtensions on String {
  String get valueOrNullString => (this.isNull || this.isEmpty) ? 'null' : this;
}

extension ObjectExtensions on dynamic {
  bool get isNull => this == null;

  bool get isNotNull => this != null;
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
