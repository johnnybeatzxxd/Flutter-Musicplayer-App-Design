import "package:flutter/material.dart";
import "package:on_audio_query/on_audio_query.dart";
import "package:musicplayer_app/index.dart";

var _audioQuery = OnAudioQuery();

Future showOptions(context,songId,_queryPlaylists) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Add to Playlist'),
              onTap: () async {
                var playlists = await _queryPlaylists();

                print(playlists[0].getMap);
                if (!playlists.isEmpty) {
                  showPlaylists(context, playlists, songId);
                } else {
                  createPlaylists(context);
                }
              }),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Rename'),
            onTap: () {
              // Add rename functionality here
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
