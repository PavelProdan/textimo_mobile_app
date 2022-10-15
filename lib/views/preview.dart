import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/services/preview_song_service.dart';

class PreviewController extends GetxController {
  dynamic argumentData = Get.arguments;
  String? songId = Get.arguments[0]['song_id'];
}

class PreviewWidget extends StatefulWidget {
  PreviewWidget({super.key});

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  final PreviewController controller = Get.put(PreviewController());
  bool isLoaded = false;
  SongSingle? nowPlayingSongDetails;

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

  Future<String> getVerseContent(String verse_number) async {
    var verseContent = await PreviewSongService()
        .getPreviewSongInfo(controller.songId!, verse_number);
    if (verseContent != null) {
      String current_verse = verseContent[0].lyricsText;
      current_verse = current_verse.replaceAll("<br>", "\n");
      return current_verse;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
        title: Text('Previzualizare melodie'),
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
            Expanded(
              child: ListView.builder(
                  itemCount:
                      int.parse(nowPlayingSongDetails?.totalNumLyrics ?? '0'),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Container(
                        color: Color.fromARGB(255, 219, 219, 219),
                        alignment: Alignment.centerLeft,
                        child: strofa_block(index),
                      ),
                      SizedBox(height: 20),
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Padding strofa_block(int index) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<String>(
            future: getVerseContent((index + 1).toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 18));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }
}
