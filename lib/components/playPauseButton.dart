import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final musicPlayer = Provider.of<playGroundProvider>(context, listen: false);
          musicPlayer.changeIsPlay();
          if (musicPlayer.isplay) {
            _controller.forward();
            musicPlayer.playTrack('https://cf-media.sndcdn.com/yJHZdaFxM1Xm.128.mp3?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiKjovL2NmLW1lZGlhLnNuZGNkbi5jb20veUpIWmRhRnhNMVhtLjEyOC5tcDMqIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzA5NjI5NzA3fX19XX0_&Signature=IB6GyPTf6kzoPndtI6tIfFIAiVMKnUSZwPLljo1lCQTIYZqoD-V1u-IG1Su1fgsHZ8jpS2RrMLowihoNeIQaaVzGo1qNPGULURG~40t9vJV0wP1qaGAGBJJjF-DogmbSkkOudmTJbYC5i3INixffIUoKKm3X8HGDcPxmfVP83nR5a4PPuAudftCE1nLDI6U9wAHwT5~Mj7mrknjYy5v7pXp4zghbcQX4dzHmBScLOgsK6WQxJZYB9vgZ6LAM7fuxSvrhc6RAVfBGSJ-Jt9oSQXE5jUto8CkQi1XV3ACayBD0oISitwT6Y-F03dRauwenszCrLKuxV5EgiXY~VkuCtA__&Key-Pair-Id=APKAI6TU7MMXM5DG6EPQ',musicPlayer.position);
          } else {
            print(musicPlayer.isplay);
            _controller.reverse();
            musicPlayer.pauseTrack();
            
          }
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
}
