import 'dart:ffi';
import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart'; // Import SchedulerBinding
import 'package:musicplayer_app/Providers/mainProvider.dart';
import "package:provider/provider.dart";
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer_app/index.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:math';
import 'package:flutter/services.dart'; // Import services for detecting headphone state
import 'package:audio_session/audio_session.dart';

class playGroundProvider extends ChangeNotifier implements TickerProvider {
  final AudioPlayer _audioPlayer = AudioPlayer();
  get audioPlayer => _audioPlayer;
  SongModel? _currentTrack;
  int? _currentTrackIndex;
  int? get currentTrackIndex => _currentTrackIndex;
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
  bool _repeat = false;
  bool get repeat => _repeat;
  bool _shuffle = false;
  bool get shuffle => _shuffle;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  List<SongModel>? _songCollection = [];
  List<SongModel>? get songCollection => _songCollection;
  AnimationController? _controller;
  AnimationController? get controller => _controller;
  Ticker? _ticker; // Declare a Ticker

  playGroundProvider() {
    _initAudioPlayer();
    _ticker = createTicker((_) {}); // Initialize the Ticker
    _initAudioSession();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
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

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        pauseTrack();
      } else {
        if (event.type != AudioInterruptionType.unknown) {
          playTrack(currentTrack!.uri!, position);
        }
      }
    });

    session.becomingNoisyEventStream.listen((_) {
      _audioPlayer.pause();
    });
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
        !_repeat ? playNextTrack() : repeatTrack();
        if (_shuffle &&
            _songCollection != null &&
            _songCollection!.isNotEmpty) {
          int randomIndex = _currentTrackIndex!;
          if (_songCollection!.length > 1) {
            // Generate a random index different from the current one
            while (randomIndex == _currentTrackIndex) {
              randomIndex = Random().nextInt(_songCollection!.length);
            }
            print(randomIndex);
          }
          // Proceed with setting the track to the randomly chosen one
          setCurrentTrack(_songCollection![randomIndex]);
          playTrack(_currentTrack!.uri!, Duration.zero);
          setCurrentArtwork();
          setCurrentTrackIndex(randomIndex);
        }
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
    if (initPosition == Duration.zero) {
      try {
        await _audioPlayer.setUrl(_currentTrack!.uri!);
      } catch (e) {
        print("Error $e");
      }
    }
    setSongDuration(_currentTrack!.duration!);
    _audioPlayer.play();
    _isplay = true;
    togglePlayButton();
    notifyListeners();
  }

  void pauseTrack() async {
    _audioPlayer.pause();
    _audioPlayer.seek(_audioPlayer.position);
    _isplay = false;
    togglePlayButton();
    notifyListeners();
  }

  void playNextTrack() {
    int? index = _currentTrackIndex;
    List? songCollection = _songCollection;
    int nextIndex = 0;

    if (_shuffle) {
        if (_songCollection != null && _songCollection!.length > 1) {
            // There are multiple songs, so we can actually shuffle
            int randomIndex = _currentTrackIndex!;
            // Generate a random index different from the current one
            do {
                randomIndex = Random().nextInt(_songCollection!.length);
            } while (randomIndex == _currentTrackIndex);
            nextIndex = randomIndex;
        } else {
            // There's only one song in the collection or the collection is null, so just repeat the current song
            nextIndex = _currentTrackIndex!;
        }
    } else {
        nextIndex = index! + 1;
        if (songCollection != null && nextIndex >= songCollection!.length) {
            nextIndex = 0; // Loop back to the first song if we've reached the end
        }
    }

    setCurrentTrack(songCollection![nextIndex]);
    playTrack(_currentTrack!.uri!, Duration.zero);
    setCurrentArtwork();
    setCurrentTrackIndex(nextIndex);
  }

  void repeatTrack() {
    int? index = _currentTrackIndex;
    List? songCollection = _songCollection;

    setCurrentTrack(songCollection![index!]);
    playTrack(_currentTrack!.uri!, Duration.zero);
    setCurrentArtwork();
    setCurrentTrackIndex(index);
  }

  void seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void setCurrentTrack(SongModel song) {
    _currentTrack = song;
    notifyListeners();
  }

  void setCurrentTrackIndex(int index) {
    _currentTrackIndex = index;
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

  void setCurrentArtwork() {
    Widget? artwork = QueryArtworkWidget(
      id: _currentTrack!.id,
      type: ArtworkType.AUDIO,
      artworkBorder: BorderRadius.zero,
      nullArtworkWidget: const Icon(Icons.music_video_rounded),
      quality: 100,
    
      artworkQuality: FilterQuality.high, 
    );
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

  void changeRepeat() {
    _repeat = !_repeat;
    _repeat ? _shuffle = false : null;
    print("repeat $_repeat");
    print("shuffle $_shuffle");
    notifyListeners();
  }

  void changeShuffle() {
    _shuffle = !_shuffle;
    _shuffle ? _repeat = false : null;
    print("repeat $_repeat");
    print("shuffle $_shuffle");
    notifyListeners();
  }

  void setFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void togglePlayButton() {
    
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
