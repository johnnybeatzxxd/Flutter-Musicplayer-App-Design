import "package:flutter/material.dart";
import "package:musicplayer_app/Providers/playgroundProvider.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:musicplayer_app/index.dart";
import "package:provider/provider.dart";

class PlaygroundPage extends StatelessWidget {
  PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    playGroundProvider musicPlayer = Provider.of<playGroundProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Song name")),
        ),
        body: Stack(alignment: AlignmentDirectional.topCenter, children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 319,
                          width: 304,
                          child: Image.asset("images/Rectangle19.png"),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(97, 86, 226, 1),
                              borderRadius: BorderRadius.circular(38)))),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Song name",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const Text(
                    "Artist name",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min, // Restrict column height
                    children: [
                      Slider(
                        activeColor: const Color.fromRGBO(97, 86, 226, 1),
                        value: musicPlayer.position.inMilliseconds.toDouble(),
                        onChanged: (value) => musicPlayer.seekTo(Duration(milliseconds: value.toInt())),
                        label: musicPlayer.slider.round().toString(),
                        min: 0,
                        max: musicPlayer.audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
                      ),
                      const SizedBox(
                          height: 0.0), // Add minimal vertical spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(musicPlayer.position.inSeconds.toDouble().toString()), // This will be on the left
                          Text(musicPlayer.position.inSeconds.toDouble().toString()), // This will be on the right
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shuffle,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous_outlined, size: 40),
                        onPressed: () {},
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: PlayPause(),
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next_outlined, size: 40),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.repeat),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight * 1.5,
                  )
                ],
              ),
            ),
          ),
          ButtomNavBar()
        ]));
  }
}
