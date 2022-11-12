import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'dart:convert';


class DeleteSongService {
 
  Future<http.Response> deleteSong(String songId) async {
  return http.delete(
    Uri.parse('${config.textimo_ip}/song/$songId'),
    
  );
}
}