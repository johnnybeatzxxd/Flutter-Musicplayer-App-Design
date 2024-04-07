import 'package:flutter/material.dart';
import 'package:musicplayer_app/Providers/playgroundProvider.dart';
import 'package:provider/provider.dart';

class PlayPause extends StatefulWidget {
  const PlayPause({super.key});

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
      }

  @override
  void dispose() {
    
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
            backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
            radius: 40,
            child: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: musicPlayer.controller!,
              size: 50,
              color: Colors.white,
            )));
  }

  void _onTap(playGroundProvider musicPlayer) {
    if (musicPlayer.isplay) {
      musicPlayer.pauseTrack();
    } else {
      musicPlayer.playTrack(
          musicPlayer.currentTrack!.uri!, musicPlayer.position);
    }
  }
}
