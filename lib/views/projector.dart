import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';

class ProjectorController extends GetxController {
  dynamic argumentData = Get.arguments;
  String? songId = Get.arguments[0]['song_id'];
  String? verseNumber = Get.arguments[1]['verse_number'];
}

class ProjectorWidget extends StatefulWidget {
  const ProjectorWidget({Key? key}) : super(key: key);

  @override
  State<ProjectorWidget> createState() => _ProjectorWidgetState();
}

class _ProjectorWidgetState extends State<ProjectorWidget> {
  final ProjectorController controller = Get.put(ProjectorController());

  SongSingle? nowPlayingSongDetails;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    getNowPlayingSongInfo();
  }

  getNowPlayingSongInfo() async {
    nowPlayingSongDetails = await GetSongInfo().getSongInfo(controller.songId!);
    if (nowPlayingSongDetails != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return a scaffold with app bar and body
    return WillPopScope(
      onWillPop: () async {
        // get back and send a require_refresh parameter to the previous page with getx
        Get.back(result: "require_refresh");
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Proiectie Live"),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F63F1),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.hide_source),
                  tooltip: 'Opreste proiectia',
                  onPressed: () {} //showDialogTest(context),

                  ),
            ],
          ),
          
          body: Visibility(
            visible: isLoaded,
            replacement: Center(child: CircularProgressIndicator()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(nowPlayingSongDetails?.songTitle ?? '',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20)),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Strofa curenta: ${controller.verseNumber} din ${nowPlayingSongDetails?.totalNumLyrics ?? ''}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
                Container(
                  color: Color.fromARGB(255, 219, 219, 219),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("jhfjdfhjhfdjdhfjhdf \nyfdjyfjdy")),
                )
              ],
            ),
          )),
    );
  }
}
