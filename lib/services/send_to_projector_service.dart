import 'package:textimo_mobile_app/models/projector_model.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class SendToProjectorService {
  Future<Projector?> sendToProjector(String liveData, String songId, String verseNumber) async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/projector');
    var response = await client.post(uri, body: {
      "live_data": liveData,
      "song_id": songId,
      "verse_number": verseNumber,
    });
    if (response.statusCode == 200) {
      var json = response.body;
      if (json.isNotEmpty) {
        return projectorFromJson(json);
      }
    } else {
      return null;
    }
  }
}