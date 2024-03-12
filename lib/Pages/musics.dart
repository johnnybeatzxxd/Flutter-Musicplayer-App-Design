import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:on_audio_query/on_audio_query.dart";

class Musics extends StatelessWidget {
  Musics({super.key});
  final _audioQuery = OnAudioQuery();
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
        future: _audioQuery.querySongs(
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
