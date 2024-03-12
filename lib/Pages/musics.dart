import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";

class Musics extends StatelessWidget {
  const Musics({super.key});

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
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.music_note),
          title: (Text("Music No $index")),
          subtitle: Text("Artist Name"),
        ),
        itemCount: 100,
      ),
    );
  }
}
