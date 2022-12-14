import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/services/preview_song_service.dart';
import 'package:textimo_mobile_app/services/send_to_projector_service.dart';
import 'package:textimo_mobile_app/services/stop_projector_service.dart';
import 'package:textimo_mobile_app/components/add_report_form.dart';

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
  bool isTextLoaded = false;
  bool isLastVerse = false;
  String? current_verse;
  String? current_verse_withBr;
  String next_btn_content = 'Strofa următoare';

  @override
  void initState() {
    super.initState();

    getNowPlayingSongInfo();
    getVerseContent();
  }

  getNowPlayingSongInfo() async {
    nowPlayingSongDetails = await GetSongInfo().getSongInfo(controller.songId!);
    if (nowPlayingSongDetails != null) {
      if (controller.verseNumber ==
          nowPlayingSongDetails?.totalNumLyrics.toString()) {
        setState(() {
          isLastVerse = true;
          next_btn_content = "Opreste proiecția";
        });
      }
      setState(() {
        isLoaded = true;
      });
    }
  }

  getVerseContent() async {
    var verseContent = await PreviewSongService()
        .getPreviewSongInfo(controller.songId!, controller.verseNumber!);
    if (verseContent != null) {
      setState(() {
        current_verse = verseContent[0].lyricsText;
        current_verse_withBr = verseContent[0].lyricsText;
        projectToLivePage(current_verse_withBr!);
        current_verse = current_verse!.replaceAll("<br>", "\n");
        isTextLoaded = true;
      });
    }
  }

  projectToLivePage(String live_verse) async {
    var sendToProjector = await SendToProjectorService().sendToProjector(
        live_verse, controller.songId!, controller.verseNumber!);
    if (sendToProjector == null) {
      Get.snackbar("Eroare! Nu s-a putut proiecta!", sendToProjector.body,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  stopLivePlaying() async {
    var stopProjector = await StopProjectorService().stopProjector();
    if (stopProjector != null) {
      Get.snackbar("Proiecția a fost oprită cu succes.", "",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Eroare!", "Proiecția nu a putut fi oprită!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return a scaffold with app bar and body
    return WillPopScope(
      onWillPop: () async {
        // get back and send a require_refresh parameter to the previous page with getx
        //Get.back(result: "require_refresh");
        Get.offAll(() => HomePage(), arguments: [
          {"require_refresh"},
        ]);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Proiecție Live"),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F63F1),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // get back and send a require_refresh parameter to the previous page with getx
                //Get.back(result: "require_refresh");
                Get.offAll(() => HomePage(), arguments: [
                  {"require_refresh"},
                ]);
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.hide_source),
                  tooltip: 'Oprește proiecția',
                  onPressed: () {
                    stopLivePlaying();
                    Get.offAll(() => HomePage(), arguments: [
                      {"require_refresh"},
                    ]);
                  } //showDialogTest(context),

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
                  child: Text(
                      "Strofa curentă: ${controller.verseNumber} din ${nowPlayingSongDetails?.totalNumLyrics ?? ''}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
                Visibility(
                  visible: isTextLoaded,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: Container(
                    color: Color.fromARGB(255, 219, 219, 219),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(current_verse ?? '',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18))),
                  ),
                ),
                SizedBox(height: 25),
                Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 25),
                GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Raportează o problemă la strofa curentă",
                          backgroundColor: Color.fromARGB(255, 236, 236, 236),
                          titleStyle: TextStyle(color: Colors.black),
                          middleTextStyle: TextStyle(color: Colors.black),
                          content: add_report_form(songId: controller.songId!, verseNumber: controller.verseNumber!),
                          radius: 10);
                    },
                    child: Container(
                      width: 500.0,
                      padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                      color: const Color(0xFFEBCE39),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Column(children: [
                        Text.rich(
                          TextSpan(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: Icon(Icons.report),
                                ),
                              ),
                              TextSpan(
                                  text:
                                      'Raportează o problemă la strofa curentă'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ]),
                    )),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      print("clicked button");
                      if (isLastVerse) {
                        stopLivePlaying();
                        Get.offAll(() => HomePage(), arguments: [
                          {"require_refresh"},
                        ]);
                      } else {
                        int nextVerse = int.parse(controller.verseNumber!) + 1;
                        Get.offAll(() => ProjectorWidget(), arguments: [
                          {"song_id": controller.songId},
                          {"verse_number": nextVerse.toString()}
                        ]);
                      }
                    },
                    child: Container(
                      width: 500.0,
                      padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Column(children: [
                        Text.rich(
                          TextSpan(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <InlineSpan>[
                              TextSpan(text: next_btn_content),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ]),
                    ))
              ],
            ),
          )),
    );
  }
}
