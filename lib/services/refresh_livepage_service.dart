import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

// create a class that makes a get request to /stop_playing route
class RefreshLivepage {
  Future<bool> refreshLivepage() async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/refresh_livepage');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}