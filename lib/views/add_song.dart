// this page will be used to add a new song to the database
// each call to this page will require 2 parameters: SongId and currentStep
//SongId is used to retrieve current song data in case if a user wants to get back to the previous step
// currentStep starts at 0. If currentStep is 0, the page will ask to insert totalnumlyrics and song_title
// from step 1 and above, this page will insert lyrics in db
// if user wants to exit the page, the created song must be deleted
// !! KNOWN ISSUE: if user force closes the app, the song will not be deleted, but when user wants to project this song, app wil crash
// This known issue can be partially solved if in the first step, the song has "TEMP" at the beginning of the song title and at the final save of the last verse, "TEMP" will be removed

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/services/delete_song_service.dart';
//import 'package:textimo_mobile_app/services/preview_one_verse_service.dart';
import 'package:textimo_mobile_app/services/preview_song_service.dart';
import 'package:textimo_mobile_app/services/update_song_title.dart';
import 'package:textimo_mobile_app/services/update_song_lyrics_service.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/views/ocr_page.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/services/add_new_song_service.dart';
import 'package:textimo_mobile_app/services/add_lyrics_service.dart';

class AddSongController extends GetxController {
  dynamic argumentData = Get.arguments;
  String? songId = Get.arguments[0]['song_id'];
  int? currentStep = Get.arguments[1]['current_step'];
}

class AddSongPage extends StatefulWidget {
  const AddSongPage({super.key});

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  final AddSongController controller = Get.put(AddSongController());

  String? songId;
  int? currentStep;
  SongSingle currentSongInfo = SongSingle(
    id: '0',
    songTitle: '0',
    totalNumLyrics: '0',
  );

  String? lyrics_content;
  bool loaded = false;
  late bool deleteOnExit;
  late bool showPreviosButton;
  late bool allowEdit;
  bool showStep0 = false;

  @override
  void initState() {
    super.initState();
    getParams();
    flowExecutor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void flowExecutor() {
    if (songId == "empty") {
      setState(() {
        loaded = true;
      });
      allowEdit =
          false; // this means that the song is new and on "Pasul urmator" press the song will be created
    } else {
      allowEdit =
          true; // this means that the song is not new and on "Pasul urmator" press the song will be updated with current data
      fetchSongInfo(songId!);
    }
  }

  void fetchSongInfo(String sondId) async {
    var response = await GetSongInfo().getSongInfo(songId!);
    if (response != null) {
      currentSongInfo = response;
    }
    setState(() {
      loaded = true;
    });
  }

  getParams() {
    songId = controller.songId;
    currentStep = controller.currentStep;

    if (songId == "empty") {
      //loaded = true;
      deleteOnExit = false;
      showPreviosButton = false;
      showStep0 = true;
    } else {
      //loaded = true;
      showPreviosButton = true;
      deleteOnExit = true;
      showStep0 = false;
    }
    if (songId!.length > 6 && currentStep == 0) {
      showStep0 = true;
      deleteOnExit = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (deleteOnExit) {
          //delete song and then go home
          Get.defaultDialog(
              title: "Atenție!",
              middleText:
                  "Dacă părăsești această pagină, melodia adăugată va fi ștearsă.",
              textConfirm: "Părăsește pagina",
              textCancel: "Anulare",
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.black,
              buttonColor: Colors.red,
              onConfirm: () async {
                final response = await DeleteSongService().deleteSong(songId!);
                if (response.statusCode == 200) {
                  Get.offAll(() => HomePage());
                } else {
                  Get.back();
                  Get.snackbar(
                      "Eroare", "A aparut o eroare la stergerea melodiei!");
                }
                Get.offAll(() => HomePage());
              },
              onCancel: () {
                Get.back();
              });
        } else {
          Get.offAll(() => HomePage());
        }
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Adaugă o melodie nouă"),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F63F1),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (deleteOnExit) {
                  //delete song and then go home
                  Get.defaultDialog(
                      title: "Atenție!",
                      middleText:
                          "Dacă părăsești această pagină, melodia adăugată va fi ștearsă.",
                      textConfirm: "Părăsește pagina",
                      textCancel: "Anulare",
                      confirmTextColor: Colors.white,
                      cancelTextColor: Colors.black,
                      buttonColor: Colors.red,
                      onConfirm: () async {
                        final response =
                            await DeleteSongService().deleteSong(songId!);
                        if (response.statusCode == 200) {
                          Get.offAll(() => HomePage());
                        } else {
                          Get.back();
                          Get.snackbar("Eroare",
                              "A aparut o eroare la stergerea melodiei!");
                        }
                        Get.offAll(() => HomePage());
                      },
                      onCancel: () {
                        Get.back();
                      });
                } else {
                  Get.offAll(() => HomePage());
                }
              },
            ),
          ),
          body: Visibility(
            visible: loaded,
            replacement: Center(child: CircularProgressIndicator()),
            // ignore: prefer_const_literals_to_create_immutables
            child: ListView(children: [
              if (showStep0) ...[
                TitleWidget(
                    showPreviosButton: showPreviosButton,
                    allowEdit: allowEdit,
                    currentSongInfo: currentSongInfo),
              ] else ...[
                AddVerseWidget(
                  allowEdit: allowEdit,
                  currentSongInfo: currentSongInfo,
                  currentStep: currentStep!,
                ),
              ]
            ]),
          )),
    );
  }
}

class TitleWidget extends StatefulWidget {
  final bool showPreviosButton;
  final bool allowEdit;
  final SongSingle currentSongInfo;

  const TitleWidget(
      {super.key,
      required this.showPreviosButton,
      required this.allowEdit,
      required this.currentSongInfo});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  final songTitleController = TextEditingController();
  final totalNumLyricsController = TextEditingController();

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getTitleAndNumLyrics();
  }

  @override
  void dispose() {
    songTitleController.dispose();
    totalNumLyricsController.dispose();
    super.dispose();
  }

  getTitleAndNumLyrics() async {
    if (widget.currentSongInfo.id != 0) {
      SongSingle? response =
          await GetSongInfo().getSongInfo(widget.currentSongInfo.id.toString());
      if (response != null) {
        songTitleController.text = response.songTitle;
        totalNumLyricsController.text = response.totalNumLyrics;
        setState(() {
          loaded = true;
        });
      }
    }

    if (widget.currentSongInfo.id == "0") {
      setState(() {
        loaded = true;
      });
    }
  }

  Future<String> addNewSong(String songTitle, String totalnumlyrics) async {
    var response = await AddNewSongService().addSong(songTitle, totalnumlyrics);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      Get.snackbar("Eroare", "A aparut o eroare la adaugarea melodiei!");
      print(
          "SongTitle: $songTitle, totalNumLyrics: $totalnumlyrics, response: ${response.body}");
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      replacement: Center(child: CircularProgressIndicator()),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
          child: Text("Titlu melodie",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
          child: SizedBox(
            //width: 70,
            child: TextField(
              controller: songTitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
          child: Text("Număr strofe:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
          child: SizedBox(
            //width: 70,
            child: TextField(
              controller: totalNumLyricsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ElevatedButton(
            onPressed: () async {
              if (widget.allowEdit == true) {
                var response = await UpdateSongTitleService().updateSongTitle(
                    widget.currentSongInfo.id.toString(),
                    songTitleController.text,
                    totalNumLyricsController.text);
                if (response.statusCode == 200) {
                  Get.offAll(() => AddSongPage(), arguments: [
                    {"song_id": widget.currentSongInfo.id},
                    {"current_step": 1}
                  ]);
                } else {
                  Get.snackbar(
                      "Eroare", "A aparut o eroare la editarea melodiei!");
                }
              } else {
                var response = await addNewSong(
                    songTitleController.text, totalNumLyricsController.text);
                if (response != "error") {
                  final data = jsonDecode(response);

                  Get.offAll(() => AddSongPage(), arguments: [
                    {"song_id": data["_id"]},
                    {"current_step": 1}
                  ]);
                }
              }
            },
            child: Text("Pasul următor"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F63F1),
            ),
          ),
        )),
      ]),
    );
  }
}

class AddVerseWidget extends StatefulWidget {
  final bool allowEdit;
  final SongSingle currentSongInfo;
  final int currentStep;

  const AddVerseWidget(
      {super.key,
      required this.allowEdit,
      required this.currentSongInfo,
      required this.currentStep});

  @override
  State<AddVerseWidget> createState() => _AddVerseWidgetState();
}

class _AddVerseWidgetState extends State<AddVerseWidget> {
  String nextButtonTitle = "Pasul următor";
  final verseController = TextEditingController();
  bool loaded = false;
  bool isFirstRequest = true;

  @override
  void initState() {
    flowExecutor();
    super.initState();
  }

  @override
  void dispose() {
    verseController.dispose();
    super.dispose();
  }

  void flowExecutor() async {
    if (widget.currentStep.toString() ==
        widget.currentSongInfo.totalNumLyrics) {
      nextButtonTitle = "Finalizare";
      setState(() {});
    }

    bool response = await checkIfLyricsExist();
    if (response == false) {
      isFirstRequest = true;
      setState(() {
        loaded = true;
      });
    }else{
      getLyricsContent();
      isFirstRequest = false;
      setState(() {
        loaded = true;
      });
    }
  }

  void getLyricsContent() async {
    var verseContent = await PreviewSongService().getPreviewSongInfo(
        widget.currentSongInfo.id.toString(), widget.currentStep.toString());
    if (verseContent != null) {
      String current_verse = verseContent[0].lyricsText;
      current_verse = current_verse.replaceAll("<br>", "\n");
      verseController.text = current_verse;
      setState(() {
        loaded = true;
      });
    }
  }

  Future<bool> addLyrics() async {
    String current_verse = verseController.text;
      current_verse = current_verse.replaceAll("\n", "<br>");
    var response = await AddNewSong().addNewSong(
        widget.currentSongInfo.id.toString(),
        widget.currentStep,
        current_verse);
    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar("Eroare", response.body);
      return false;
    }
  }

  Future<bool> checkIfLyricsExist() async {
    print(widget.currentSongInfo.id);
    var verseContent = await PreviewSongService().getPreviewSongInfo(
        widget.currentSongInfo.id.toString(), widget.currentStep.toString());
    if (verseContent!.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  void updateLyrics() async{
    String current_verse = verseController.text;
    current_verse = current_verse.replaceAll("\n", "<br>");
    var response = await UpdateSongLyricsService().updateSongLyrics(widget.currentSongInfo.id, widget.currentStep.toString(), current_verse);
    if(response.statusCode == 200){
    }else{
      Get.snackbar("Eroare", response.body);
    }
  }

  void useOcr() async {
    var data = await Get.to(OcrView());
    print(data);
    if(data==null){
      verseController.text = "";
    }else{
      verseController.text = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      replacement: Center(child: CircularProgressIndicator()),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
            child: Text("Conținut strofă " + widget.currentStep.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
            child: TextField(
              controller: verseController,
              maxLines: 10,
              minLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ElevatedButton(
              onPressed: () {
                // open ocr page
                useOcr();
              },
              child: Text("Adaugă conținut folosind camera"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 27, 197, 21),
              ),
            ),
          )),
          Divider(
            color: Color.fromARGB(255, 88, 88, 88),
            height: 20,
            thickness: 1,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ElevatedButton(
              onPressed: () {

                if (isFirstRequest == true) {
                  addLyrics();

                  if (widget.currentStep ==
                      int.parse(widget.currentSongInfo.totalNumLyrics)) {
                    Get.offAll(() => HomePage());
                  } else {
                    Get.offAll(() => AddSongPage(), arguments: [
                      {"song_id": widget.currentSongInfo.id},
                      {"current_step": widget.currentStep + 1}
                    ]);
                  }
                } else {
                  //update lyrics
                  updateLyrics();

                  if (widget.currentStep ==
                      int.parse(widget.currentSongInfo.totalNumLyrics)) {
                    Get.offAll(() => HomePage());
                  } else {
                    Get.offAll(() => AddSongPage(), arguments: [
                      {"song_id": widget.currentSongInfo.id},
                      {"current_step": widget.currentStep + 1}
                    ]);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F63F1),
              ),
              child: Text(nextButtonTitle),
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ElevatedButton(
              onPressed: () {
                if (isFirstRequest == true) {
                  addLyrics();
                Get.offAll(() => AddSongPage(), arguments: [
                  {"song_id": widget.currentSongInfo.id},
                  {"current_step": widget.currentStep - 1}
                ]);
                } else {
                  //update lyrics
                  updateLyrics();
                  Get.offAll(() => AddSongPage(), arguments: [
                  {"song_id": widget.currentSongInfo.id},
                  {"current_step": widget.currentStep - 1}
                ]);
                }
              },
              child: Text("Pasul anterior"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 241, 63, 72),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
