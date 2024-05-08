import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;
  onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
