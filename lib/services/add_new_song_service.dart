import 'dart:convert';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class AddNewSongService {
  Future<http.Response> addSong(String songTitle, String totalnumlyrics) async {
  return http.post(
    Uri.parse('${config.textimo_ip}/add_song'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "song_title": "$songTitle",
      "total_num_lyrics": "$totalnumlyrics",
    }),
  );
}
}