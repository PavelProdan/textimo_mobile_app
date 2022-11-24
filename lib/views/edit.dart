import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/services/preview_song_service.dart';
import 'package:textimo_mobile_app/services/update_song_title.dart';
import 'package:textimo_mobile_app/services/update_song_lyrics_service.dart';

class EditController extends GetxController {
  dynamic argumentData = Get.arguments;
  String? songId = Get.arguments[0]['song_id'];
}

class EditWidget extends StatefulWidget {
  const EditWidget({super.key});

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  final EditController controller = Get.put(EditController());
  TextEditingController editController = TextEditingController();
  SongSingle? nowPlayingSongDetails;
  bool isLoaded = false;
  int number_of_verses = 0;

  @override
  void initState() {
    super.initState();
    getNowPlayingSongInfo();
    getVerseCount();
  }

  getNowPlayingSongInfo() async {
    nowPlayingSongDetails = await GetSongInfo().getSongInfo(controller.songId!);
    if (nowPlayingSongDetails != null) {
      setState(() {
        editController.text = nowPlayingSongDetails!.songTitle;
        isLoaded = true;
      });
    }
  }

  updateSongLyrics(String verse_number, String text) async {
    var response = await UpdateSongLyricsService()
        .updateSongLyrics(controller.songId!, verse_number, text);
    print(response);
    if (response.statusCode == 200) {
      //Get.snackbar("Succes", "Versurile au fost actualizate cu succes");
    } else {
      Get.snackbar("Eroare actualizare versuri:", response.body);
    }
  }

  updateSongTitleAndNumLyrics() async {
    int total_num_lyrics = await getVerseCount();
    var response = await UpdateSongTitleService().updateSongTitle(
        controller.songId!, editController.text, total_num_lyrics.toString());
    if (response.statusCode == 200) {
      //setState(() {});
      Get.snackbar(
        "Succes",
        "Datele au fost actualizate cu succes",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: Duration(milliseconds: 300),
        forwardAnimationCurve: Curves.easeIn,
      );
    } else {
      Get.snackbar(
        "Eroare",
        "Datele nu au putut fi actualizate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: Duration(milliseconds: 300),
        forwardAnimationCurve: Curves.easeIn,
      );
    }
  }

  Future<int> getVerseCount() async {
    var verseCount = await GetSongInfo().getSongInfo(controller.songId!);
    if (verseCount != null) {
      number_of_verses = int.parse(verseCount.totalNumLyrics);
      return int.parse(verseCount.totalNumLyrics);
    } else {
      return 0;
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
    late List<TextEditingController> verseController;

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
          centerTitle: true,
          backgroundColor: const Color(0xFF3F63F1),
          title: Text('Modificare melodie'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: TextField(
                  controller: editController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Titlu melodie',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoaded,
              replacement: Center(child: CircularProgressIndicator()),
              child: Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: () {
                            Form.of(primaryFocus!.context!)!.save();
                          },
                          child: FutureBuilder<int>(
                              future: getVerseCount(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  verseController = List.generate(
                                      snapshot.data ?? 0,
                                      (i) => TextEditingController());
                                  return Wrap(
                                    children: List<Widget>.generate(
                                        snapshot.data ?? 0, (int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ConstrainedBox(
                                            constraints: BoxConstraints.expand(
                                              width: 300.0,
                                              height: 150.0,
                                            ),
                                            child: FutureBuilder<String>(
                                                future: getVerseContent(
                                                    (index + 1).toString()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    verseController[index]
                                                            .text =
                                                        snapshot.data ?? '';
                                                    return TextFormField(
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      textInputAction:
                                                          TextInputAction
                                                              .newline,
                                                      maxLines: 10,
                                                      minLines: 10,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0),
                                                      ),
                                                      controller:
                                                          verseController[
                                                              index],
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        "${snapshot.error}");
                                                  }
                                                  return Transform.scale(
                                                    scale: 0.5,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                })),
                                      );
                                    }),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              })),
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color(0xFF3F63F1), // foreground
                            ),
                            onPressed: () {
                              // aici avem acces la verseController[number].text, dar nu este implementat in backend optiunea de update strofa
                              if (number_of_verses != 0) {
                                for (int i = 0; i < number_of_verses; i++) {
                                  String current_verse =
                                      verseController[i].text;
                                  current_verse =
                                      current_verse.replaceAll("\n", "<br>");
                                  updateSongLyrics(
                                      (i + 1).toString(), current_verse);
                                }
                              }
                              updateSongTitleAndNumLyrics();
                            },
                            child: Text('Salvează modificările'))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
