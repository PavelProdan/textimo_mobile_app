import 'package:flutter/material.dart';
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
            title: Text('Adauga o piesa noua'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setari'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Ajutor'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text('Raportari'),
            onTap: () {},
          ),
          Divider(
            height: 5,
            thickness: 1,
            color: Color(0XFFCECECE),
          ),
          ListTile(
            title: Text('Versiune aplicatie: v1.0'),
          ),
          Divider(
            height: 3,
            thickness: 1,
            color: Color(0XFFCECECE),
          ),
          ListTile(
            title: Text('Aplicatie dezvoltata de Pavel Prodan in 2022'),
          ),
        ],
      ),
    );
  }

