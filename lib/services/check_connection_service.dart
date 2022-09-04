import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:textimo_mobile_app/config/config.dart' as config;


class CheckConnectionService {
  Future<String?> checkConnection() async {
    try {
      var response = await http
          .get(Uri.parse('${config.textimo_ip}/CheckForConnection'))
          .timeout(const Duration(seconds: 2), onTimeout: () {
        return http.Response('Error', 408);
      });
      if (response.statusCode == 200) {
        return "true";
      } else {
        return "false";
      }
    } on SocketException {
      return "exception raised";
    }

  }

  }
