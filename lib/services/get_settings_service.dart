import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'package:textimo_mobile_app/models/get_settings_model.dart';

class GetNowPlayingSong {
  
  // create a future function that fetch the data from the api and then converts the json to dart object. 
  Future<GetSettings?> getSettings() async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/get_livepage_settings');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return getSettingsFromJson(json);
    } else {
      return null;
    }
  }

}