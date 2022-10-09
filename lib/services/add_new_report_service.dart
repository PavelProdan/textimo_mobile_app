import 'dart:convert';
import 'package:textimo_mobile_app/models/new_report_model.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class AddNewReportService {
  Future<http.Response> addNewReport(String songId, String verseNumber, String report) async {
  return http.post(
    Uri.parse('${config.textimo_ip}/add_report'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "song_id": "$songId",
      "verse_number": "$verseNumber",
      "report_text": "$report",
      "report_status": "Nou",
    }),
  );
}
}