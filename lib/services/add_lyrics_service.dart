import 'dart:convert';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class AddNewSong {
  Future<http.Response> addNewSong(String songId, int verse_number, String text_content) async {
  return http.post(
    Uri.parse('${config.textimo_ip}/add_lyrics/$songId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "lyrics_text": "$text_content",
      "verse_number": verse_number.toString(),
    }),
  );
}
}