import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/home_page.dart';

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
        // body: Center(
        //   child: Text("Now playing song with id: ${controller.songId} and verse number: ${controller.verseNumber}"),
        // ),
        
        // add body that contains a centered title and a text aligned to the left
        body: Column(
  children: <Widget>[
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text("now_playing_song_title",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20)),
      ),
    ),
    SizedBox(height: 40),
    
Text("Strofa curenata: ${controller.verseNumber}/total",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15))    
  ],
)

      ),
    );
  }
}