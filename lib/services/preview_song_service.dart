import 'package:textimo_mobile_app/models/preview_song_model.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class PreviewSongService {
  Future<List<PreviewSong>?> getPreviewSongInfo(String songId, String verse_number) async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/preview/$songId/$verse_number');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      if (json.isNotEmpty) {
        return previewSongFromJson(json);
      }
    } else {
      return null;
    }
  }
}