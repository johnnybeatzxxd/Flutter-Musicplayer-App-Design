import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Store {
  void saveRecentlyPlayedSong(SongModel song) {}

  void saveFavoriteSong(SongModel song) {
    var map = {
      "id": song.id,
    };
    List favorites = Hive.box("Musics").get("Favorites") ?? [];
    if (!checkIfSongIsFavorite(song)) {
      favorites.add(map);
      Hive.box("Musics").put("Favorites", favorites);
    } else {
      favorites.removeWhere((element) => element["id"] == song.id);
      Hive.box("Musics").put("Favorites", favorites);
    }
  }

  bool checkIfSongIsFavorite(SongModel song) {
    List favorites = Hive.box("Musics").get("Favorites") ?? [];
    return favorites.any((element) => element["id"] == song.id);
  }
  // Add more functions for saving different types of songs or playlists as needed
}

