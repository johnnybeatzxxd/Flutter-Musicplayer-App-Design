import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:permission_handler/permission_handler.dart";
import "package:provider/provider.dart";
import "package:musicplayer_app/index.dart";

class Musics extends StatefulWidget {
  Musics({super.key});
  final _audioQuery = OnAudioQuery();

  @override
  _MusicsState createState() => _MusicsState();
}

class _MusicsState extends State<Musics> {
  @override
  void initState() async {
    super.initState();
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, proceed with the operation
    } else if (status.isDenied) {
      Provider.of<MainProvider>(context, listen: true).currentPage(0);
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }

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
      body: FutureBuilder<List<SongModel>>(
        future: widget._audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL_PRIMARY,
            ignoreCase: true),
        builder: (context, music) {
          if (music.data!.isEmpty) {
            return const Center(
              child: Text("No Songs Found"),
            );
          }
          if (music.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(music.data![index].displayNameWOExt),
                subtitle: Text(music.data![index].artist.toString()),
                trailing: const Icon(Icons.more_horiz),
              ),
              itemCount: 100,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
