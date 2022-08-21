import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/textimoLogo.png',
            height: 40, fit: BoxFit.cover),
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search a song',
            onPressed: () {},
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Color(0xFFD9D9D9),
        label: Column(
          children: const [
            Text('Se vizualizeaza live:',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400)
            ),
            Text('The current song name',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800)
            ),
          ],
        ),
        onPressed: () {},
    ),
      ),
    floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,

      drawer: drawer(),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Drawer drawer() {
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
}
