import "package:flutter/material.dart";
import "package:on_audio_query/on_audio_query.dart";

var _audioQuery = OnAudioQuery();
Future showPlaylists(context, playlists, songId) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Playlists',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, num) {
                return Card(
                  color: Theme.of(context).colorScheme.background,
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      '${playlists[num].playlist.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _audioQuery.addToPlaylist(playlists[num].id, songId);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createPlaylists(context);
            },
            child: Text(
              'Create New Playlist',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future createPlaylists(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController playlistNameController = TextEditingController();
      return AlertDialog(
        title: const Text('Create Playlist'),
        content: TextField(
          controller: playlistNameController,
          decoration: const InputDecoration(
            hintText: 'Playlist Name',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'Create',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            onPressed: () {
              _audioQuery.createPlaylist(playlistNameController.text);
              // Add functionality to create playlist with playlistNameController.text
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
