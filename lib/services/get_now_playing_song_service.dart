import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'package:textimo_mobile_app/models/now_playing_model.dart';

class GetNowPlayingSong {
  
  // create a future function that fetch the data from the api and then converts the json to dart object. 
  Future<NowPlayingSong?> getNowPlayingSong() async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/now_playing');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return nowPlayingSongFromJson(json);
    } else {
      return null;
    }
  }

}