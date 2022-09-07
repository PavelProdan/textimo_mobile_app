import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/check_connection.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/services/check_connection_service.dart';
import 'package:textimo_mobile_app/views/connection_guide.dart';

// ignore_for_file: prefer_const_constructors

void main() {
  runApp(
    GetMaterialApp(
      home: CheckConnectionWidget(),
    ),
  );
}