import "package:flutter/material.dart";
import "package:on_audio_query/on_audio_query.dart";

Future playlistSongsList(context, songs) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 20,
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              SongModel song = songs[index];
              return ListTile(
                leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.zero,
                    format: ArtworkFormat.JPEG,
                    artworkFit: BoxFit.cover,
                    
                    nullArtworkWidget: const Icon(Icons.music_video)),
                title: Text(song.title),
                subtitle: Text(song.artist ?? ""),
                onTap: () {},
              );
            },
          ));
    },
  );
}
