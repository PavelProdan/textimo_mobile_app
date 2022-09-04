import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/services/check_connection_service.dart';
import 'package:textimo_mobile_app/views/connection_guide.dart';
// ignore_for_file: prefer_const_constructors

class CheckConnectionWidget extends StatefulWidget {
  const CheckConnectionWidget({Key? key}) : super(key: key);

  @override
  State<CheckConnectionWidget> createState() => _CheckConnectionWidgetState();
}

class _CheckConnectionWidgetState extends State<CheckConnectionWidget> {
  String isConnected = "init";
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getConnectionStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getConnectionStatus() async {
    var connectionStatus = await CheckConnectionService().checkConnection();
    if (connectionStatus != null) {
      // check if connectionStatus is true
      if (connectionStatus == "true") {
        Get.offAll(HomePage());
      } else {
        Get.to(ConnectionGuide());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: // display a loading indicator in the center and underneath a text that contains the status. 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Se verifica conexiunea..."),
                ),
              ],
            ),
          ),
    );
  }
}
