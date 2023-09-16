import 'dart:math';

class CalculateHelpers {
  static String calculateBMI(dynamic weight, dynamic height) {
    var _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }
}
