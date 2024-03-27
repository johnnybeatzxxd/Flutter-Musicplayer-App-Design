import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Store {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  void saveRecentlyPlayedSong(SongModel song) {
    var map = {
      "id": song.id,
      "title": song.title,
    };
    List recentlyPlayed = Hive.box("Musics").get("RecentlyPlayed") ?? [];
    recentlyPlayed.removeWhere((song) => song["id"] == map["id"]); // Remove the song if it's already in the list
    if (recentlyPlayed.length >= 6) {
      recentlyPlayed.removeAt(0); // Remove the first (oldest) song
    }
    recentlyPlayed.add(map); // Add the new song
    Hive.box("Musics").put("RecentlyPlayed", recentlyPlayed);
  }
  List<Map<String, dynamic>>  getRecentlyPlayedSongs(){
    List recentlyPlayed = Hive.box("Musics").get("RecentlyPlayed") ?? [];
    return recentlyPlayed.map((recent) => {"id": recent["id"], "title": recent["title"]} as Map<String, dynamic>).toList();
  }
  void saveFavoriteSong(SongModel song) {
    var map = {
      "id": song.id,
      "title": song.title
      
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
