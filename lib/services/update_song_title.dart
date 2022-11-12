import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'dart:convert';


class UpdateSongTitleService {
 
  Future<http.Response> updateSongTitle(String songId, String songTitle, String total_num_lyrics) async {
  return http.put(
    Uri.parse('${config.textimo_ip}/song/$songId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "song_title": "$songTitle",
      "total_num_lyrics": "$total_num_lyrics"
    }),
  );
}
}