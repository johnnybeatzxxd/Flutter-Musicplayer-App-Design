import "package:flutter/material.dart";
import "package:provider/provider.dart";

class playGroundProvider extends ChangeNotifier {
  bool _isplay = false;
  get isplay => _isplay;
  double _slider = 0.0;
  get slider => _slider;

  changePlayButtonIcon() {
    _isplay = !_isplay;
    notifyListeners();
  }

  setSlider(value){
    _slider = value;
    notifyListeners();
  }
}
