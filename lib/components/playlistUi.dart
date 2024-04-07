import "package:flutter/material.dart";
import "package:musicplayer_app/index.dart";
import "package:provider/provider.dart";
import "package:on_audio_query/on_audio_query.dart";

var _audioQuery = OnAudioQuery();
Future showPlaylists(context, playlists, songId) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
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
                      playlists[num].playlist.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _audioQuery.addToPlaylist(playlists[num].id, songId);
                        Navigator.pop(context);
                        var currentPageIndex =
                            Provider.of<MainProvider>(context,listen: false).currentPageIndex;
                        Provider.of<MainProvider>(context,listen: false)
                            .currentPage(currentPageIndex);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
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
              var currentPageIndex =
                  Provider.of<MainProvider>(context,listen: false).currentPageIndex;
              Provider.of<MainProvider>(context,listen: false).currentPage(currentPageIndex);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(97, 86, 226, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Create New Playlist',
              style: TextStyle(
                color: Colors.white,
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
              var currentPageIndex =
                  Provider.of<MainProvider>(context,listen: false).currentPageIndex;
              Provider.of<MainProvider>(context,listen: false).currentPage(currentPageIndex);
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
              var currentPageIndex =
                  Provider.of<MainProvider>(context,listen: false).currentPageIndex;
              Provider.of<MainProvider>(context,listen: false).currentPage(currentPageIndex);
            },
          ),
        ],
      );
    },
  );
}
