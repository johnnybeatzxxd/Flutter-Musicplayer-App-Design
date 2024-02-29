import "package:flutter/material.dart";
import "package:provider/provider.dart";

class playGroundProvider extends ChangeNotifier {
  bool _isplay = false;
  get isplay => _isplay;

  changePlayButtonIcon() {
    _isplay = !_isplay;
    notifyListeners();
  }
}
