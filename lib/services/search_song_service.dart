import 'package:textimo_mobile_app/models/song.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class SearchService{
  Future<List<Song>?> searchSong(String query) async{
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/search/$query');
    var response =  await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return songFromJson(json);
    }else{
      return null;
    }
    
  }
}