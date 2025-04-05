import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int newIndex) {
    if (_currentIndex == newIndex) return;
    _currentIndex = newIndex;
    notifyListeners();
  }
}
