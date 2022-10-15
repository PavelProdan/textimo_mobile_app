import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/services/preview_song_service.dart';

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

  @override
  void initState() {
    super.initState();
    getNowPlayingSongInfo();
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

  Future<int> getVerseCount() async {
    var verseCount = await GetSongInfo().getSongInfo(controller.songId!);
    if (verseCount != null) {
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

    return Scaffold(
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
                                                  verseController[index].text =
                                                      snapshot.data ?? '';
                                                  return TextFormField(
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                    maxLines: 10,
                                                    minLines: 10,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0),
                                                    ),
                                                    controller:
                                                        verseController[index],
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      "${snapshot.error}");
                                                }
                                                return CircularProgressIndicator();
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
                            print(editController.text);
                          },
                          child: Text('Salvează modificările'))),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                        child: Text(
                            "Momentan nu este posibilă modificarea versurilor, doar titlul se va salva !")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
