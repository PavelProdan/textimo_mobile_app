import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'package:textimo_mobile_app/models/song_single.dart';

class GetSongInfo{
  
  Future<SongSingle?> getSongInfo(String songId) async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/song/$songId');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return songSingleFromJson(json);
    } else {
      return null;
    }
  }
}