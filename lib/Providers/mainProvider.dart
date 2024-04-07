import "package:flutter/material.dart";

class MainProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  get currentPageIndex => _currentPageIndex;

  void currentPage(index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  
}
