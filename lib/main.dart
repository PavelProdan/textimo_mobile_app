import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/views/homeAPI.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      home: HomePage(),
    );
  }
}


