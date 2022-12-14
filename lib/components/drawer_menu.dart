import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/views/reports.dart';
import 'package:textimo_mobile_app/views/settings.dart';
import 'package:textimo_mobile_app/views/add_song.dart';
import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors

Drawer drawer_menu() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 100,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3F63F1),
              ),
              child: Image(
                image: AssetImage('assets/textimoLogo.png'),
              )),
        ),
        
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text('Adaugă o piesă nouă'),
          onTap: () {
            Get.to(() => AddSongPage(), arguments: [
              {"song_id": "empty"},
              {"current_step": 0}
            ]);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setări'),
          onTap: () {
            Get.to(SettingsPage());
          },
        ),
        ListTile(
          leading: Icon(Icons.report),
          title: Text('Raportări'),
          onTap: () {
            Get.to(ReportsPage());
          },
        ),
        Divider(
          height: 5,
          thickness: 1,
          color: Color(0XFFCECECE),
        ),
        ListTile(
          title: Text('Versiune aplicație: v1.1'),
        ),
        Divider(
          height: 3,
          thickness: 1,
          color: Color(0XFFCECECE),
        ),
        ListTile(
          title: Text('Aplicație dezvoltată de Pavel Prodan în 2022'),
        ),
      ],
    ),
  );
}
