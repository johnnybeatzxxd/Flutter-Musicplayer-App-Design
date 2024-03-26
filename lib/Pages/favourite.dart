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
                  "Favourite Ablum",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SingleChildScrollView(
                    controller: ScrollController(initialScrollOffset: 0.0),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var album in albums)
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(album["image"],
                                        width: 106, height: 111),
                                  ),
                                ),
                                Text(
                                  album["name"],
                                ),
                              ],
                            ),
                          )
                      ],
                    )), // Favorite album section
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 4,
                    ),
                    padding: const EdgeInsets.only(bottom: 85),
                    itemCount: db.getFavoriteSongs().length,
                    itemBuilder: (context, index) {
                      var favoriteSongs = db.getFavoriteSongs();
                      var songId = favoriteSongs[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              SongModel? song = await db.getSongModel(songId);
                              var playGround = Provider.of<playGroundProvider>(
                                  context,
                                  listen: false);
                              playGround.setCurrentTrack(song!);
                              playGround.playTrack(
                                  playGround.currentTrack!.uri ?? '',
                                  Duration.zero);
                              playGround.setCurrentArtwork();
                              playGround.setCurrentTrackIndex(index);
                              playGround.setSongDuration(song.duration!);
                              List<SongModel> favoriteSongsList = [];
                              for (var songId in favoriteSongs) {
                                SongModel? song = await db.getSongModel(songId);
                                if (song != null) {
                                  favoriteSongsList.add(song);
                                }
                              }
                              playGround.setSongCollection(favoriteSongsList);
                              playGround.setNeedsRefresh(true);
                              Provider.of<MainProvider>(context, listen: false)
                                  .currentPage(4);
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
}
