import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:musicplayer_app/index.dart";

class MainProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  get currentPageIndex => _currentPageIndex;

  void currentPage(index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  
}
