import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/views/homeAPI.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/services/check_connection_service.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String isConnected = "init";
  var isLoading = false;
 
  @override
  void initState(){
    super.initState();

    getConnectionStatus();
  }

  getConnectionStatus() async {
    var connectionStatus = await CheckConnectionService().checkConnection();
    if(connectionStatus != null){
      // check if connectionStatus is true
      if(connectionStatus=="true"){
        setState(() {
          isConnected = connectionStatus;
          isLoading = true;
        });
      } else {
        setState(() {
          isConnected = connectionStatus;
          isLoading = true;
        });
      }
    }
  }
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: Visibility(
          visible: isLoading,
          // ignore: sort_child_properties_last
          child: Text("The current connection status is: ${isConnected}"),
        
          replacement:const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );

    
  }
}
