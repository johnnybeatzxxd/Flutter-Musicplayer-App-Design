import 'package:flutter/material.dart';
import 'package:musicplayer_app/Providers/mainProvider.dart';
import 'package:musicplayer_app/Providers/playgroundProvider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class PlayPause extends StatefulWidget {
  const PlayPause({super.key});

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  refreshPage() {
    print("no");
    Provider.of<MainProvider>(context, listen: true).currentPage(2);
  }

  @override
  void dispose() {
    //_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayer = Provider.of<playGroundProvider>(context, listen: false);
    return GestureDetector(
        onTap: () {
          _onTap(musicPlayer);
        },
        child: CircleAvatar(
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _controller,
              size: 50,
              color: Colors.white,
            ),
            backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
            radius: 40));
  }

  void _onTap(playGroundProvider musicPlayer) {
    musicPlayer.changeIsPlay();
    if (musicPlayer.isplay) {
      _controller.forward();
      musicPlayer.playTrack("url", musicPlayer.position);
    } else {
      _controller.reverse();
      musicPlayer.pauseTrack();
    }
  }
}
