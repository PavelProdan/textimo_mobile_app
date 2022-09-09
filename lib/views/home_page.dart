import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/components/drawer_menu.dart';
import 'package:textimo_mobile_app/views/connection_guide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore_for_file: prefer_const_constructors

import '../models/song.dart';
import '../services/get_songs_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<Song> _songs;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _songs = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    // fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$_pageNumber&_limit=$_numberOfPostsPerRequest"));
      List responseList = json.decode(response.body);
      List<Post> postList = responseList.map((data) => Post(data['title'], data['body'])).toList();

      setState(() {
        _isLastPage = postList.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _posts.addAll(postList);

      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }



  //// old code
  var songsLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getSongs();
  }

  getSongs() async {
    songs = await GetSongsService().getSongs();
    if (songs != null) {
      setState(() {
        songsLoaded = true;
      });
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
      body: buildSongsView(),
      // body: Visibility(
      //   visible: songsLoaded,
      //   // ignore: sort_child_properties_last
      //   child: ListView.builder(
      //       itemCount: songs?.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return Card(
      //           child: ListTile(
      //             title: InkWell(
      //               onTap: () {},
      //               child: Padding(
      //                 padding: const EdgeInsets.all(13.0),
      //                 child: Text(songs![index].songTitle),
      //               ),
      //             ),
      //             trailing: PopupMenuButton<String>(
      //               onSelected: (String value) {},
      //               itemBuilder: (BuildContext context) =>
      //                   <PopupMenuEntry<String>>[
      //                 const PopupMenuItem<String>(
      //                   value: 'Afiseaza',
      //                   child: Text('Afișează'),
      //                 ),
      //                 const PopupMenuItem<String>(
      //                   value: 'Previzualizeaza',
      //                   child: Text('Previzualizează'),
      //                 ),
      //                 const PopupMenuItem<String>(
      //                   value: 'Modifica',
      //                   child: Text('Modifică'),
      //                 ),
      //                 const PopupMenuItem<String>(
      //                   value: 'Sterge',
      //                   child: Text('Șterge'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       }),
      //   replacement: const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }

  Widget buildSongsView() {
    if (_posts.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: errorDialog(size: 20)
        );
      }
    }
      return ListView.builder(
          itemCount: _posts.length + (_isLastPage ? 0 : 1),
          itemBuilder: (context, index) {

            if (index == _posts.length - _nextPageTrigger) {
              fetchData();
            }
            if (index == _posts.length) {
              if (_error) {
                // return Center(
                //     child: errorDialog(size: 15)
                // );
              } else {
                return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
              }
            }
            final Post post = _posts[index];
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: PostItem(post.title, post.body)
            );
          });
    }
}
