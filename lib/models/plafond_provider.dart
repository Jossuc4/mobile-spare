import 'package:flutter/material.dart';

class PlafondProvider with ChangeNotifier {
  double _plafond = 100;

  double get plafond => _plafond;

  void setPlafond(double newPlafond) {
    _plafond = newPlafond;
    notifyListeners();
  }
}
