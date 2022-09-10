import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/components/drawer_menu.dart';
import 'package:textimo_mobile_app/views/connection_guide.dart';
// ignore_for_file: prefer_const_constructors

import '../models/song.dart';
import '../services/get_songs_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song>? songs;
  var songsLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getSongs();
  }

  getSongs() async {
    songs = await GetSongsService().getSongswithPagination(3,20);
    if (songs != null) {
      if(songs!.isEmpty){
        print("e gol");
      }
      setState(() {
        songsLoaded = true;
      });
    }else{
      print("i expected this");
    }
  }

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
      body: Visibility(
        visible: songsLoaded,
        // ignore: sort_child_properties_last
        child: ListView.builder(
            itemCount: songs?.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(songs![index].songTitle),
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
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}