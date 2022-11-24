import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;
import 'dart:convert';


class UpdateReportService {
 
  Future<http.Response> updateReportStatus(String reportId) async {
  return http.put(
    Uri.parse('${config.textimo_ip}/reports'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "report_id": "$reportId",
      "report_status": "Finalizat"
    }),
  );
}
}