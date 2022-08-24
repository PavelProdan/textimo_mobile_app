import 'dart:async';
  import 'dart:io';
  
  import 'package:flutter/material.dart';
  import 'package:connectivity_plus/connectivity_plus.dart';
  
  void main() => runApp(MyApp());
  
  class MyApp extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Woolha.com Flutter Tutorial',
        home: ConnectivityStatusExample(),
      );
    }
  }
  
  extension ParseToString on ConnectivityResult {
  
    String toValue() {
      return this.toString().split('.').last;
    }
  }
  
  class ConnectivityStatusExample extends StatefulWidget {
  
    @override
    State<StatefulWidget> createState() {
      return _ConnectivityStatusExampleState();
    }
  }
  
  class _ConnectivityStatusExampleState extends State<ConnectivityStatusExample> {
  
    static const TextStyle textStyle = const TextStyle(
      fontSize: 16,
    );
  
    ConnectivityResult? _connectivityResult;
    late StreamSubscription _connectivitySubscription;
    bool? _isConnectionSuccessful;
  
    @override
    initState() {
      super.initState();
  
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
          ConnectivityResult result
      ) {
        print('Current connectivity status: $result');
        setState(() {
          _connectivityResult = result;
        });
      });
    }
  
    @override
    dispose() {
      super.dispose();
  
      _connectivitySubscription.cancel();
    }
  
    Future<void> _checkConnectivityState() async {
      final ConnectivityResult result = await Connectivity().checkConnectivity();
  
      if (result == ConnectivityResult.wifi) {
        print('Connected to a Wi-Fi network');
      } else if (result == ConnectivityResult.mobile) {
        print('Connected to a mobile network');
      } else {
        print('Not connected to any network');
      }
  
      setState(() {
        _connectivityResult = result;
      });
    }
  
    Future<void> _tryConnection() async {
      try {
        final response = await InternetAddress.lookup('www.woolha.com');
  
        setState(() {
          _isConnectionSuccessful = response.isNotEmpty;
        });
      } on SocketException catch (e) {
        print(e);
        setState(() {
          _isConnectionSuccessful = false;
        });
      }
    }
  
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: const Text('Woolha.com Flutter Tutorial'),
          backgroundColor: Colors.teal,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Connection status: ${_connectivityResult?.toValue()}',
                style: textStyle,
              ),
              Text(
                'Is connection success: $_isConnectionSuccessful',
                style: textStyle,
              ),
              OutlinedButton(
                child: const Text('Check internet connection'),
                onPressed: () => _checkConnectivityState(),
              ),
              OutlinedButton(
                child: const Text('Try connection'),
                onPressed: () => _tryConnection(),
              ),
            ],
          ),
        ),
      );
    }
  }