import 'package:flutter/material.dart';

class SelectedDate with ChangeNotifier {
  var _date = DateTime.now();

  DateTime get date => _date;

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  bool isSelected(DateTime date) {
    if (_date.day == date.day &&
        _date.month == date.month &&
        _date.year == date.year) return true;
    return false;
  }
}
