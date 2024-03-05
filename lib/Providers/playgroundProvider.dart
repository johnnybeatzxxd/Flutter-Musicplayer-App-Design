import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:just_audio/just_audio.dart';

class playGroundProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  get audioPlayer => _audioPlayer;
  String? _currentTrack;
  Duration _position = Duration.zero;
  bool _isplay = false;
  get isplay => _isplay;
  double _slider = 0.0;
  get slider => _slider;
  double _maxSlider = 120;
  get maxSlider => _maxSlider;
  Duration get position => _position;
  String? get currentTrack => _currentTrack;
  playGroundProvider() {
    _initAudioPlayer();
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _initAudioPlayer() async {
    _audioPlayer.playerStateStream.listen((playerState) {
      _isplay = playerState.playing;
      if (playerState.processingState == ProcessingState.idle ||
          playerState.processingState == ProcessingState.loading ||
          playerState.processingState == ProcessingState.buffering ||
          playerState.processingState == ProcessingState.ready) {
        // Handle non-error state
      } else if (playerState.processingState == ProcessingState.completed) {
        // Handle track completion here (e.g., play next track)
        // Example: _playNextTrack();
      } else {
        // Handle error state
        // You can access the error through playerState.error
      }
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners(); // Notify UI of changes
    });
  }

  Future<void> playTrack(String url, Duration initPosition) async {
    await _audioPlayer.setAsset("assets/icons/RaGe.mp3");
    await _audioPlayer.seek(initPosition);
    await _audioPlayer.play();
    _currentTrack = url;
    _isplay = true;
    notifyListeners();
  }

  void pauseTrack() async {
    await _audioPlayer.pause();
    _isplay = false;
    notifyListeners();
  }

  void seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  changeIsPlay() {
    _isplay = !_isplay;
    notifyListeners();
  }

  setSlider(value) {
    _slider = value;
    notifyListeners();
  }

  setMaxSlider(value) {
    _maxSlider = value;
    notifyListeners();
  }

  String intToTime(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();
    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();
    String result = h > 0
        ? "$hourLeft:$minuteLeft:$secondsLeft"
        : "$minuteLeft:$secondsLeft";
    return result;
  }
}
