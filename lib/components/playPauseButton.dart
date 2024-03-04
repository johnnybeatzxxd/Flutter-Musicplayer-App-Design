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
          final provider = Provider.of<playGroundProvider>(context, listen: false);
          provider.changeIsPlay();
          if (provider.isplay) {
            print(provider.isplay);
            _controller.forward();
            Timer.periodic(Duration(seconds: 1), (Timer t) {
              if (provider.isplay) {
                var currentTime = provider.slider;
                provider.setSlider(currentTime + 1);
                print(provider.slider);
              } else {
                t.cancel();
              }
            });
          } else {
            _controller.reverse();
          }
        },
        child: CircleAvatar(
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _controller,
              size: 50,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(97, 86, 226, 1),
            radius: 40));
  }
}
