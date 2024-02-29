import 'package:flutter/material.dart';

class PlayPause extends StatefulWidget {
  const PlayPause({super.key});

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> with TickerProviderStateMixin {
  bool _isplay = false;
  late AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300)); // Made animation faster by reducing duration to 250 milliseconds
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
          setState(() {
            if (_isplay) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            _isplay = !_isplay;
          });
        },
        child: CircleAvatar(
            child: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: _controller,
              size: 50,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(97, 86, 226, 1),
            radius: 40));
  }
}
