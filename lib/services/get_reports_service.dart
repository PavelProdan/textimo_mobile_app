import 'dart:convert';
import 'package:textimo_mobile_app/models/view_reports_model.dart';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class GetAllReports{
  Future<List<ViewReports>?> getAllReports() async {
    var client = http.Client();
    var uri = Uri.parse('${config.textimo_ip}/reports');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return viewReportsFromJson(json);
    } else {
      return null;
    }
  }
}