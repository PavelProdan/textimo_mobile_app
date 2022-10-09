import 'dart:convert';

import 'package:textimo_mobile_app/models/projector_model.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;


class SendToProjectorService {
  // Future<bool?> sendToProjector(String liveData, String songId, String verseNumber) async {
  //   var client = http.Client();
  //   var uri = Uri.parse('${config.textimo_ip}/projector');
  //   var response = await client.post(uri, body: {
  //     "live_data": "$liveData",
  //     "song_id": "$songId",
  //     "verse_number": "$verseNumber",
  //   });
  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     if (json.isNotEmpty) {
  //       return true;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  Future<http.Response> sendToProjector(String liveData, String songId, String verseNumber) async {
  return http.post(
    Uri.parse('${config.textimo_ip}/projector'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "live_data": "$liveData",
       "song_id": "$songId",
       "verse_number": "$verseNumber"
    }),
  );
}
}