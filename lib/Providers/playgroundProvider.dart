import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart'; // Import SchedulerBinding
import 'package:musicplayer_app/Providers/mainProvider.dart';
import "package:provider/provider.dart";
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer_app/index.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playGroundProvider extends ChangeNotifier implements TickerProvider {
  final AudioPlayer _audioPlayer = AudioPlayer();
  get audioPlayer => _audioPlayer;
  SongModel? _currentTrack;
  Duration _position = Duration.zero;
  bool _isplay = true;
  get isplay => _isplay;
  double _slider = 0.0;
  get slider => _slider;
  double _maxSlider = 120;
  get maxSlider => _maxSlider;
  Duration get position => _position;
  SongModel? get currentTrack => _currentTrack;
  Widget? _currentArtwork;
  Widget? get currentArtwork => _currentArtwork;
  int? _songDuration;
  int? get songDuration => _songDuration;

  List<SongModel> _songCollection = [];
  List<SongModel> get songCollection => _songCollection;
  AnimationController? _controller;
  AnimationController? get controller => _controller;
  Ticker? _ticker; // Declare a Ticker

  
  playGroundProvider() {
    _initAudioPlayer();
    _ticker = createTicker((_) {}); // Initialize the Ticker
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller?.dispose();
    _ticker?.dispose(); // Dispose of the Ticker
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'playGroundProviderTicker');
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
        pauseTrack();
        seekTo(Duration.zero);
      } else {
        // Handle error state
        // You can access the error through playerState.error
      }
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((position) {
      _position = position;
      _audioPlayer.duration?.inSeconds.toDouble() ==
              _position.inSeconds.toDouble()
          ? _isplay = true
          : null;

      notifyListeners();
    });
  }

  Future<void> playTrack(String uri, Duration initPosition) async {
    initPosition == Duration.zero
        ? _audioPlayer.setUrl(_currentTrack!.uri!)
        : null;
    _audioPlayer.play();
    _isplay = true;
    togglePlayButton();
    notifyListeners();
  }

  void pauseTrack() async {
    await _audioPlayer.pause();
    await _audioPlayer.seek(_audioPlayer.position);
    _isplay = false;
    togglePlayButton();
    notifyListeners();
  }

  void seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void setCurrentTrack(SongModel song) {
    _currentTrack = song;
    notifyListeners();
  }

  void setSongDuration(int duration) {
    _songDuration = duration;
    notifyListeners();
  }

  void setSongCollection(List<SongModel> songs) {
    _songCollection = songs;
    notifyListeners();
  }

  void setCurrentArtwork(Widget artwork) {
    _currentArtwork = artwork;
    notifyListeners();
  }

  changeIsPlay() {
    _isplay = !_isplay;

    notifyListeners();
  }

  setSlider(double value) {
    _slider = value;
    notifyListeners();
  }

  setMaxSlider(value) {
    _maxSlider = value;
    notifyListeners();
  }

  void togglePlayButton() {
    _controller ??= AnimationController(
      vsync: this, // Use this class as the TickerProvider
      duration: Duration(milliseconds: 300),
    );
    if (!_isplay) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
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
