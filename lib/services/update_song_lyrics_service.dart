import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateSongLyricsService {
  Future<http.Response> updateSongLyrics(
      String songId, String verse_number, String text) async {
    return http.put(
      Uri.parse('${config.textimo_ip}/editVerse/$songId/$verse_number'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"lyrics_text": text}),
    );
  }
}
