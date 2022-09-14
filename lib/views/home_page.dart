import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/components/drawer_menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:textimo_mobile_app/services/get_now_playing_song_service.dart';
import 'package:textimo_mobile_app/models/now_playing_model.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';

// ignore_for_file: prefer_const_constructors

import '../models/song.dart';
import '../services/get_songs_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song> songs = [];
  NowPlayingSong? nowPlayingSong;
  SongSingle? nowPlayingSongInfo;
  String now_playing_song_title = '';

  int limit = 10; // this variable never changes, its part of config
  int offset = 0;
  bool is_now_playing_btn_visible = false;

  @override
  void initState() {
    super.initState();
    
    // get now playing song btn
    getNowPlayingSong();
  }

  getNowPlayingSong() async {
    nowPlayingSong =  await GetNowPlayingSong().getNowPlayingSong();
    if(nowPlayingSong != null){
      if(nowPlayingSong?.songId == "0"){
        setState(() {
          is_now_playing_btn_visible = false;
        });
      }else{
        nowPlayingSongInfo = await GetSongInfo().getSongInfo(nowPlayingSong!.songId);
        if(nowPlayingSongInfo != null){
          setState(() {
            now_playing_song_title = nowPlayingSongInfo!.songTitle;
            is_now_playing_btn_visible = true;
          });
        }
      }
      
    }

  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> retrieveSongs({bool isRefresh = false}) async {
    if (isRefresh) {
      offset = 0;
    }

    final response = await GetSongsService().getSongswithPagination(limit, offset);

    if (response != null) {
        if (isRefresh) {
          songs = response;
        } else {
          songs.addAll(response);
        }
        offset = offset + limit;
     
      setState(() {});
      return true;
      
    } else {
      return false;
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
      floatingActionButton: Visibility(
        visible: is_now_playing_btn_visible,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton.extended(
            elevation: 4.0,
            backgroundColor: Color(0xFFD9D9D9),
            label: Column(
              children: [
                Text('Se vizualizeaza live:',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                Text(now_playing_song_title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800)),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: drawer_menu(),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await retrieveSongs(isRefresh: true);
          getNowPlayingSong();
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await retrieveSongs();
          if(result){
            refreshController.loadComplete();
          }else{
            refreshController.loadFailed();
          }
        },
        child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (BuildContext context, int index) {
              
              return Card(
                child: ListTile(
                  title: InkWell(
                    onTap: () {
                      // open song projector page
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(songs[index].songTitle),
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        //_selectedMenu = item.name;
                      });
                    },
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
      ),
    );
  }
}
