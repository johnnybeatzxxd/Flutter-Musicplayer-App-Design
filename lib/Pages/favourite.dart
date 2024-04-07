import "package:flutter/material.dart";
import "package:musicplayer_app/index.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:provider/provider.dart";

class FavoritePage extends StatelessWidget {
  List albums = [
    {"name": "Album 1", "image": "images/Rectangle24.png"},
    {"name": "Album 2", "image": "images/Rectangle23.png"},
    {"name": "Album 3", "image": "images/Rectangle22.png"}
  ];
  final db = Store();
  final _audioQuery = OnAudioQuery();
  FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        child: Image.asset("images/RectangleProfile.png",
                            width: 91, height: 100),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            "Sarwar Jahan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500, // Make the name bold
                            ),
                          ),
                          Text(
                            "sarwarmusic@gmail.com",
                          ),
                          Text(
                            "Gold Member",
                          ),
                          Text(
                            "Love Music and I am not an Musician.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Text(
                  "Playlists",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SingleChildScrollView(
                  controller: ScrollController(initialScrollOffset: 0.0),
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: _queryPlaylists(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<PlaylistModel> playlists = snapshot.data!;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var playlist in playlists)
                              InkWell(
                                onTap: () async {
                                  print(playlist.getMap["_data"]);
                                  var audios =
                                      await _audioQuery.queryAudiosFrom(
                                    AudiosFromType.PLAYLIST,
                                    playlist.id.toString(),
                                    orderType: OrderType.ASC_OR_SMALLER,
                                    ignoreCase: true,
                                  );
                                  print(audios);
                                  playlistSongsList(context, audios);
                                                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: 106,
                                            height: 111,
                                            child: FittedBox(
                                                child: QueryArtworkWidget(
                                              id: playlist.id,
                                              quality: 100,
                                              artworkQuality: FilterQuality.high,
                                              artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                              format: ArtworkFormat.PNG,
                                              size: 500,
                                              type: ArtworkType.PLAYLIST,
                                              artworkBorder: BorderRadius.zero,
                                              nullArtworkWidget: const Icon(Icons.music_video_rounded)
                                            )),
                                          )),
                                    ),
                                    Text(
                                      playlist.playlist,
                                    ),
                                  ],
                                ),
                              ),
                            InkWell(
                              onTap: () {
                                createPlaylists(context);
                                
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 106,
                                        height: 111,
                                        color: const Color.fromARGB(82, 33, 33, 33),
                                        child: const Icon(Icons.add, size: 60,color:Color.fromRGBO(98, 86, 226, 1),),
                                      ),
                                    ),
                                  ),
                                  const Text("Create Playlist"),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("Error!");
                      }
                    },
                  ),
                ), // Favorite album section
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Favourite Music",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 4,
                    ),
                    padding: const EdgeInsets.only(bottom: 85),
                    itemCount: db.getFavoriteSongs().length,
                    itemBuilder: (context, index) {
                      var favoriteSongs =
                          db.getFavoriteSongs().reversed.toList();
                      var songId = favoriteSongs[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
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
                                List<SongModel> favoriteSongsList = [];
                                for (var songId in favoriteSongs) {
                                  SongModel? song =
                                      await db.getSongModel(songId);
                                  if (song != null) {
                                    favoriteSongsList.add(song);
                                  }
                                }
                                playGround.setSongCollection(favoriteSongsList);
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
                            child: Container(
                              width: 106,
                              height: 111,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FittedBox(
                                    child: QueryArtworkWidget(
                                      id: songId,
                                      type: ArtworkType.AUDIO,
                                      format: ArtworkFormat.JPEG,
                                      quality: 100,
                                      artworkBorder: BorderRadius.zero,
                                      nullArtworkWidget: const Icon(null),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ), //end of the page
          ButtomNavBar()
        ]));
  }

  Future<List<PlaylistModel>> _queryPlaylists() async {
    var playlists = await _audioQuery.queryPlaylists(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      sortType: null,
    );

    return playlists;
  }
}
