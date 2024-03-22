import "package:flutter/material.dart";
import "package:musicplayer_app/Providers/playgroundProvider.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:musicplayer_app/index.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:provider/provider.dart";

class PlaygroundPage extends StatelessWidget {
  PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    playGroundProvider musicPlayer = Provider.of<playGroundProvider>(context);
    return WillPopScope(
    onWillPop: () async {
      Provider.of<MainProvider>(context, listen: false).currentPage(1);
      return false; // Return false to prevent default back navigation
    },
    child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<MainProvider>(context, listen: false).currentPage(1);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: musicPlayer.isFavorite
                    ? const Color.fromRGBO(97, 86, 226, 1)
                    : null,
              ),
              onPressed: () {
                musicPlayer.setFavorite();
              },
            ),
          ],
          title: Center(child: Text(musicPlayer.currentTrack!.title)),
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
                          ? '${musicPlayer.currentTrack?.displayNameWOExt.substring(0, 29)}...'
                          : musicPlayer.currentTrack?.displayNameWOExt ??
                              'Unknown Song',
                      style: const TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    musicPlayer.currentTrack?.artist ?? 'Unkown Album',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min, // Restrict column height
                    children: [
                      Slider(
                        activeColor: Color.fromRGBO(97, 86, 226, 1),
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
                        icon: Icon(
                          Icons.repeat,
                          color: musicPlayer.repeat
                              ? const Color.fromRGBO(97, 86, 226, 1)
                              : null,
                        ),
                        onPressed: () {
                          musicPlayer.changeRepeat();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous_outlined, size: 40),
                        onPressed: () {
                          int? index = musicPlayer.currentTrackIndex;
                          List? songCollection = musicPlayer.songCollection;
                          if (index != null && index > 0) {
                            musicPlayer
                                .setCurrentTrack(songCollection?[index - 1]);
                            musicPlayer.setCurrentTrackIndex(index! - 1);
                            musicPlayer.setCurrentArtwork();
                            musicPlayer.playTrack(
                                musicPlayer.currentTrack!.uri!, Duration.zero);
                          } else {
                            musicPlayer.playTrack(
                                musicPlayer.currentTrack!.uri!, Duration.zero);
                          }
                        },
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
                        child: const PlayPause(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_outlined, size: 40),
                        onPressed: () {
                          musicPlayer.playNextTrack();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shuffle,
                          color: musicPlayer.shuffle
                              ? const Color.fromRGBO(97, 86, 226, 1)
                              : null,
                        ),
                        onPressed: () {
                          musicPlayer.changeShuffle();
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
        ])
        ),);
  }
}
