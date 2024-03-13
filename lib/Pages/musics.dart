import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:permission_handler/permission_handler.dart";
import "package:provider/provider.dart";
import "package:musicplayer_app/index.dart";

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
                  child: CircularProgressIndicator(),
                );
              } else if (music.hasData && music.data!.isEmpty) {
                return const Center(
                  child: Text("No Songs Found"),
                );
              } else if (music.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    leading: const Icon(Icons.music_note),
                    title: Text(music.data![index].displayNameWOExt),
                    subtitle: Text(music.data![index].artist.toString()),
                    trailing: const Icon(Icons.more_horiz),
                  ),
                  itemCount: music.data!.length,
                );
              } else {
                print(music.connectionState);
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
    var status = await Permission.storage.request();
    print("request sent!");
    if (status.isGranted) {
      // Permission granted, proceed with the operation
      return widget._audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL_PRIMARY,
        ignoreCase: true,
      );
    } else if (status.isDenied) {
      Provider.of<MainProvider>(context).currentPage(0);
      return Future.error("Permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
      return Future.error("Permission permanently denied");
    }
    return Future.error("Unknown error");
  }
}
