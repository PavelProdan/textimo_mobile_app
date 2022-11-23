import 'dart:convert';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class PreviewOneVerseService {
  Future<http.Response> preview(String songId, String verse_number) async {
  return http.get(
    Uri.parse('${config.textimo_ip}/preview/$songId/$verse_number'),
    
  );
}
}