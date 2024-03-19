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
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 319,
                        width: 304,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(38),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: musicPlayer.currentArtwork,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      (musicPlayer.currentTrack?.displayNameWOExt?.length ??
                                  0) >
                              25
                          ? '${musicPlayer.currentTrack?.displayNameWOExt.substring(0, 30)}...'
                          : musicPlayer.currentTrack?.displayNameWOExt ??
                              'Unknown Song',
                      style: const TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    musicPlayer.currentTrack?.album ?? 'Unkown Album',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min, // Restrict column height
                    children: [
                      Slider(
                        activeColor: const Color.fromRGBO(97, 86, 226, 1),
                        value: musicPlayer.position.inSeconds.toDouble(),
                        onChanged: (value) => musicPlayer
                            .seekTo(Duration(seconds: value.toInt())),
                        label: musicPlayer.slider.round().toString(),
                        min: 0,
                        max: musicPlayer.songDuration != null
                            ? musicPlayer.songDuration!.toDouble() / 1000 + 0.2
                            : 0.0,
                      ),
                      const SizedBox(
                          height: 0.0), // Add minimal vertical spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(musicPlayer.intToTime(musicPlayer
                              .position.inSeconds
                              .toDouble()
                              .toInt())),
                          Text(musicPlayer.intToTime(
                              (musicPlayer.songDuration! / 1000).toInt() ?? 0)),
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
                        icon: Icon(
                          Icons.repeat,
                          color: musicPlayer.repeat ? const Color.fromRGBO(97, 86, 226, 1) : Colors.white,
                        ),
                        onPressed: () {
                          musicPlayer.changeRepeat();
                        },
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
