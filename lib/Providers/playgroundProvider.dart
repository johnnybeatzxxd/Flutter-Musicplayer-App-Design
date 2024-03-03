import "package:flutter/material.dart";
import "package:provider/provider.dart";

class playGroundProvider extends ChangeNotifier {
  bool _isplay = false;
  get isplay => _isplay;
  double _slider = 0.0;
  get slider => _slider;
  double _maxSlider = 120;
  get maxSlider => _maxSlider;

  changePlayButtonIcon() {
    _isplay = !_isplay;
    notifyListeners();
  }

  setSlider(value){
    _slider = value;
    notifyListeners();
  }

  setMaxSlider(value){
    _maxSlider = value;
    notifyListeners();
  }
  String intToTime(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();
    String result = h > 0 ? "$hourLeft:$minuteLeft:$secondsLeft" : "$minuteLeft:$secondsLeft";
    return result;
  }
}
