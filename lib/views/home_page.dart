import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/components/drawer_menu.dart';
// ignore_for_file: prefer_const_constructors

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
            onPressed: () {} //showDialogTest(context),

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
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
              Text('The current song name',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
            ],
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: drawer_menu(),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text("Example song number number $index"),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Afiseaza',
                      child: Text('Afișează'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Previzualizeaza',
                      child: Text('Previzualizează'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Modifica',
                      child: Text('Modifică'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sterge',
                      child: Text('Șterge'),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

