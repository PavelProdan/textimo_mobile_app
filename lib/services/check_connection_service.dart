import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:textimo_mobile_app/config/config.dart' as config;


class CheckConnectionService {
  //async function named checkConnection that uses http module to call the route /CheckForConeection and uses config.textimo_ip
  // to get the response from the server and return the http response back to the async function
  // the function use a duration method to set the timeout to 1 second
  // if the server responds within 1 second the function returns the response
  // if the call does not responsd within 1 second with a http status code 200, the function returns null
 
  //_ClinetSocketException is a custom exception that is thrown when the server does not respond within 1 second. We have to manage this exception and return false
  // to the calling function

  // the function must be in a try catch block


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

  // Future<bool?> checkConnection() async {
  //   var client = http.Client();
  //   var uri = Uri.parse("${config.textimo_ip}/CheckForConnection");
  //   var response = await client.get(uri).timeout(
  //     const Duration(seconds: 1),
  //     onTimeout: () {
  //       // Time has run out, do what you wanted to do.
  //       return http.Response('Error', 408); // Request Timeout response status code
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
