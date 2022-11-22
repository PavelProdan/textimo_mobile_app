// this page will be used to add a new song to the database
// each call to this page will require 2 parameters: SongId and currentStep
//SongId is used to retrieve current song data in case if a user wants to get back to the previous step
// currentStep starts at 0. If currentStep is 0, the page will ask to insert totalnumlyrics and song_title
// from step 1 and above, this page will insert lyrics in db
// if user wants to exit the page, the created song must be deleted
// !! KNOWN ISSUE: if user force closes the app, the song will not be deleted, but when user wants to project this song, app wil crash
// This known issue can be partially solved if in the first step, the song has "TEMP" at the beginning of the song title and at the final save of the last verse, "TEMP" will be removed

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';

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
  bool loaded = false;
  late bool deleteOnExit;
  late bool showPreviosButton;

  @override
  void initState() {
    super.initState();
    getParams();
  }

  getParams() {
    songId = controller.songId;
    currentStep = controller.currentStep;

    if (songId == "empty") {
      loaded = true;
      deleteOnExit = false;
      showPreviosButton = false;
    }else{
      loaded = true;
      showPreviosButton = true;
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
                            middleText: "Dacă părăsești această pagină, melodia adăugată va fi ștearsă.",
                            textConfirm: "Părăsește pagina",
                            textCancel: "Anulare",
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            buttonColor: Colors.red,
                            onConfirm: () async {
                              // final response = await DeleteSongService().deleteSong(songs[index].id);
                              // if(response.statusCode==200){
                              //   Get.back();
                              //   Get.snackbar("Succes", "Melodia a fost stearsa cu succes!");
                              //   retrieveSongs(isRefresh: true);
                              // }else{
                              //   Get.back();
                              //   Get.snackbar("Eroare", "A aparut o eroare la stergerea melodiei!");
                              // }
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
                            middleText: "Dacă părăsești această pagină, melodia adăugată va fi ștearsă.",
                            textConfirm: "Părăsește pagina",
                            textCancel: "Anulare",
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            buttonColor: Colors.red,
                            onConfirm: () async {
                              // final response = await DeleteSongService().deleteSong(songs[index].id);
                              // if(response.statusCode==200){
                              //   Get.back();
                              //   Get.snackbar("Succes", "Melodia a fost stearsa cu succes!");
                              //   retrieveSongs(isRefresh: true);
                              // }else{
                              //   Get.back();
                              //   Get.snackbar("Eroare", "A aparut o eroare la stergerea melodiei!");
                              // }
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
              if (!deleteOnExit) ...[
                TitleWidget(),
              ] else ...[
                Text("songId: $songId"),
              ]
            ]),
          )),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
            //controller: text_font_sizeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
        child: Text("Numar strofe:",
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
            //controller: text_font_sizeController,
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
          onPressed: () {
            Get.offAll(() => AddSongPage(), arguments: [
              {"song_id": "not empty"},
              {"current_step": 1}
            ]);
          },
          child: Text("Pasul urmator"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F63F1),
          ),
        ),
      )),
    ]);
  }
}
