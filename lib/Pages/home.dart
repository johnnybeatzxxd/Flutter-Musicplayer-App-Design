import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:musicplayer_app/index.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:provider/provider.dart";
import "dart:math";

class Homepage extends StatelessWidget {
  final List<Map> recommendations = [
    {
      "name": "Take care of you",
      "image": "images/rectangle7.png",
      "artist": "Admina Thembi",
      "views": "114k/stream",
    },
    {
      "name": "The stranger inside you",
      "image": "images/Rectangle8.png",
      "artist": "Jeane Lebras",
      "views": "60.5k/stream",
    },
    {
      "name": "Edwall of beauty mind",
      "image": "images/Rectangle9.png",
      "artist": "Jacob Givson",
      "views": "44.3k/stream",
    },
    {
      "name": "Take care of you",
      "image": "images/rectangle7.png",
      "artist": "Admina Thembi",
      "views": "114k/stream",
    }
  ];
  final db = Store();

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () {},
          child: Container(
              height: 40,
              width: 40,
              child: CircleAvatar(
                child: Image.asset("images/profile.png"),
              )),
        ),
        title: const Column(
          children: [
            Text(
              "Sarwar Jahan",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Gold Member",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
              color: const Color.fromRGBO(142, 142, 142, 1),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Listen The\nLatest Musics',
                          style: TextStyle(
                              fontSize: 26,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              width: 180,
                              height: 48,
                              child: TextField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade700),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(60))),
                                    hintText: "       Search Music",
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white70),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)))),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "Recently Played",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Nunito",
                      ),
                    ),
                    SizedBox(
                      height:
                          117.0, // Adjust the height according to your needs
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: db.getRecentlyPlayedSongs().length,
                        itemBuilder: (context, index) {
                          var recentlyPlayed =
                              db.getRecentlyPlayedSongs().reversed.toList();
                          var songId = recentlyPlayed[index]["id"];
                          var songTitle = recentlyPlayed[index]["title"];
                          var songModel = db.getSongModel(songId);
                          return InkWell(
                            onTap: () async{
                              var playGround = Provider.of<playGroundProvider>(
                                  context,
                                  listen: false);
                              if (songId != playGround.currentTrack?.id) {
                                SongModel? song = await db.getSongModel(songId);
                                playGround.setCurrentTrack(song!);
                                playGround.playTrack(
                                    playGround.currentTrack!.uri ?? '',
                                    Duration.zero);
                                playGround.setCurrentArtwork();
                                playGround.setCurrentTrackIndex(index);
                                playGround.setSongDuration(song.duration!);
                                List<SongModel> recentlyPlayedSongsList = [];
                                for (var songId in recentlyPlayed) {
                                  SongModel? song =
                                      await db.getSongModel(songId["id"]);
                                  if (song != null) {
                                    recentlyPlayedSongsList.add(song);
                                  }
                                }
                                playGround.setSongCollection(recentlyPlayedSongsList);
                                playGround.setNeedsRefresh(true);
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .currentPage(4);
                              } else {
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .currentPage(4);
                              }
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 101.0,
                                    height: 81.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: QueryArtworkWidget(
                                        id: songId,
                                        type: ArtworkType.AUDIO,
                                        artworkBorder: BorderRadius.zero,
                                        artworkFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(songTitle.substring(
                                    0, min<int>(12, songTitle.length))),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        child: Text(
                          "Recommend for you",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var music in recommendations)
                            InkWell(
                              onTap: () {
                                print("pressed!");
                              },
                              child: Ink(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 10, 12),
                                      child: Container(
                                        width: 88.0,
                                        height: 88.0,
                                        child: Image.asset(music["image"]),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Text(music["name"]),
                                          Text(
                                            music["artist"],
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          Text(
                                            music["views"],
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kBottomNavigationBarHeight * 1.4,
                    )
                  ],
                ),
              ),
            ),
          ),
          ButtomNavBar()
        ],
      ),
    );
  }
}
