import "package:flutter/material.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:permission_handler/permission_handler.dart";
import "package:provider/provider.dart";
import "package:musicplayer_app/index.dart";
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lottie/lottie.dart';

class MusicsPage extends StatefulWidget {
  MusicsPage({super.key});
  final _audioQuery = OnAudioQuery();
  @override
  _MusicsPageState createState() => _MusicsPageState();
}

class _MusicsPageState extends State<MusicsPage> {
  final PageStorageKey _musicsPageKey = const PageStorageKey('musicsPageKey');

  @override
  Widget build(BuildContext context) {
    var playGround = Provider.of<playGroundProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Musics"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(children: [
        FutureBuilder<List<SongModel>>(
          future: playGround.songCollection != null &&
                  playGround.songCollection!.isNotEmpty &&
                  playGround.needsRefresh == false
              ? Future.value(playGround.songCollection)
              : _checkPermissionAndQuerySongs(),
          builder: (context, music) {
            if (music.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(97, 86, 226, 1),
                ),
              );
            } else if (music.hasData && music.data!.isEmpty) {
              return const Center(
                child: Text("No Songs Found"),
              );
            } else if (music.data == null) {
              return const Center(
                child: Text("Permission needed!"),
              );
            } else if (music.connectionState != ConnectionState.waiting) {
              return ListView.builder(
                key: _musicsPageKey, // Assign the PageStorageKey here
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) => InkWell(
                  onLongPress: () {
                    int songId = music.data![index].id;
                    showOptions(context, songId, _queryPlaylists);
                  },
                  onTap: () {
                    playGround.setCurrentTrackIndex(index);
                    if (music.data![index].uri !=
                        playGround.currentTrack?.uri) {
                      playGround.setCurrentTrack(music.data![index]);
                      playGround.playTrack(
                          playGround.currentTrack!.uri ?? '', Duration.zero);
                      playGround.setCurrentArtwork();
                      playGround.setSongDuration(music.data![index].duration!);
                      playGround.setSongCollection(music.data!);
                      Provider.of<MainProvider>(context, listen: false)
                          .currentPage(4);
                    } else {
                      Provider.of<MainProvider>(context, listen: false)
                          .currentPage(4);
                    }
                  },
                  child: ListTile(
                    leading: QueryArtworkWidget(
                        id: music.data![index].id,
                        type: ArtworkType.AUDIO,
                        format: ArtworkFormat.PNG,
                        artworkQuality: FilterQuality.low,
                        size: 100,
                        nullArtworkWidget: const Padding(
                            padding: EdgeInsets.all(13),
                            child: Icon(Icons.music_note)),
                        artworkBorder: BorderRadius.zero),
                    title: ValueListenableBuilder<int?>(
                      valueListenable: playGround.currentTrackIdNotifier,
                      builder: (context, currentTrackId, child) {
                        return Text(
                          music.data![index].displayNameWOExt,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: playGround.currentTrack != null &&
                                    playGround.currentTrack!.id ==
                                        music.data![index].id &&
                                    playGround.isplay
                                ? const Color.fromRGBO(97, 86, 226, 1)
                                : null,
                          ),
                        );
                      },
                    ),
                    subtitle: Text(music.data![index].artist.toString()),
                    trailing: ValueListenableBuilder<int?>(
                      valueListenable: playGround.currentTrackIdNotifier,
                      builder: (context, currentTrackId, child) {
                        var songId = music.data![index].id;
                        return currentTrackId == songId && playGround.isplay
                            ? Lottie.asset(
                                "assets/animations/wave.json",
                                height: 35,
                                width: 35,
                                frameRate: FrameRate.max,
                              )
                            : IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {
                                  int songId = music.data![index].id;
                                  showOptions(context, songId, _queryPlaylists);
                                },
                              );
                      },
                    ),
                  ),
                ),
                itemCount: music.data == null ? 0 : music.data!.length,
              );
            } else {
              return const Center(
                child: Text("Error fetching songs"),
              );
            }
          },
        ),
        ButtomNavBar()
      ]),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: playGround.isplayNotifier,
        builder: (context, isPlaying, child) {
          return isPlaying
              ? Container(
                  margin: const EdgeInsets.fromLTRB(
                      0, 0, 10, 85), // Move the button up a little bit
                  child: FloatingActionButton(
                    onPressed: () {
                      Provider.of<MainProvider>(context, listen: false)
                          .currentPage(4);
                    },
                    backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }

  Future<List<SongModel>> _checkPermissionAndQuerySongs() async {
    PermissionStatus status;
    int sdkVersion = await DeviceInfoPlugin()
        .androidInfo
        .then((info) => info.version.sdkInt);
    print("sdkVersion $sdkVersion");
    if (sdkVersion < 33) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.audio.request();
    }
    print(status);

    if (status == PermissionStatus.denied) {
      print("permission denied");
      openAppSettings();
      await Future.delayed(const Duration(
          seconds: 5)); // Wait for the user to potentially allow permission
      if (await Permission.storage.isPermanentlyDenied ||
          await Permission.audio.isPermanentlyDenied) {
        // If the user still didn't allow permission after opening settings
        return Future.error("Permission not allowed");
      }
    }
    if (status == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
      return Future.error("Permission permanently denied");
    }
    if (status == PermissionStatus.granted) {
      print("Granted");
      // Permission granted, proceed with the operation
      var songs = await widget._audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      return songs;
    } else {
      return Future.error("Unknown error");
    }
  }

  Future<List<PlaylistModel>> _queryPlaylists() async {
    var playlists = await widget._audioQuery.queryPlaylists(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      sortType: null,
    );

    return playlists;
  }
}
