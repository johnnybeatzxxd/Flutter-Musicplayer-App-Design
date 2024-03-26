import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Store {
  final OnAudioQuery _audioQuery = OnAudioQuery();
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
  List<int> getFavoriteSongs(){
    List favorites = Hive.box("Musics").get("Favorites") ?? [];
    return favorites.map((favorite) => favorite["id"] as int).toList();
  }
  bool checkIfSongIsFavorite(SongModel song) {
    List favorites = Hive.box("Musics").get("Favorites") ?? [];
    return favorites.any((element) => element["id"] == song.id);
  }

  Future<SongModel?> getSongModel(int id) async{
    List<SongModel> songs = await _audioQuery.querySongs();
    return songs.firstWhere((song) => song.id == id, orElse: () => null as SongModel);
  }
  // Add more functions for saving different types of songs or playlists as needed
}
