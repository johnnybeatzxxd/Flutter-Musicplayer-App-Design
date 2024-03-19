import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:permission_handler/permission_handler.dart";
import "package:provider/provider.dart";
import "package:musicplayer_app/index.dart";
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class MusicsPage extends StatefulWidget {
  MusicsPage({super.key});
  final _audioQuery = OnAudioQuery();
  @override
  _MusicsPageState createState() => _MusicsPageState();
}

class _MusicsPageState extends State<MusicsPage> {
  @override
  Widget build(BuildContext context) {
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
            future: _checkPermissionAndQuerySongs(),
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
              }else if (music.data == null) {
                return const Center(
                  child: Text("Permission needed!"),
                );
              } else if (music.connectionState != ConnectionState.waiting) {
                return ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      var playGround = Provider.of<playGroundProvider>(context,
                          listen: false);

                      if (music.data![index].uri !=
                          playGround.currentTrack?.uri) {
                        playGround.setCurrentTrack(music.data![index]);
                        playGround.playTrack(
                            playGround.currentTrack!.uri ?? '', Duration.zero);
                        var currentArtwork = FutureBuilder(
                          future: widget._audioQuery.queryArtwork(
                              music.data![index].id, ArtworkType.AUDIO),
                          builder: (context, artwork) {
                            if (artwork.connectionState ==
                                ConnectionState.done) {
                              return artwork.data == null
                                  ? const Icon(Icons.music_video_rounded,)//MyCustomIcon("assets/icons/music.svg",color: Colors.white,height: 20,width: 20,)
                                  : Image.memory(artwork.data!);
                            } else {
                              return const Icon(Icons.music_note);
                            }
                          },
                        );
                        playGround.setCurrentArtwork(currentArtwork);
                        playGround
                            .setSongDuration(music.data![index].duration!);
                        Provider.of<MainProvider>(context, listen: false)
                            .currentPage(4);
                        
                      } else {
                        Provider.of<MainProvider>(context, listen: false)
                            .currentPage(4);
                      }
                      
                    },
                    child: ListTile(
                      leading: FutureBuilder<Widget>(
                        future: getAudioArtwork(music.data![index].id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return snapshot.data!;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      title: Text(music.data![index].displayNameWOExt),
                      subtitle: Text(music.data![index].artist.toString()),
                      trailing: const Icon(Icons.more_horiz),
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
        ]));
  }

  Future<List<SongModel>> _checkPermissionAndQuerySongs() async {
    var status;
    int sdkVersion = await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt);
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
      await Future.delayed(Duration(seconds: 5)); // Wait for the user to potentially allow permission
      if (await Permission.storage.isPermanentlyDenied || await Permission.audio.isPermanentlyDenied) {
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

  Future<Widget> getAudioArtwork(int id) async {
    final artworkData =
        await widget._audioQuery.queryArtwork(id, ArtworkType.AUDIO);
    if (artworkData != null) {
      return Image.memory(artworkData);
    } else {
      // Return a placeholder icon
      return const Padding(
          padding: EdgeInsets.all(16), child: Icon(Icons.music_note));
    }
  }
}
