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

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => HomePage());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Adaugă o melodie"),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F63F1),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAll(() => HomePage());
              },
            ),
          ),
          body: Visibility(
            visible: true,
            replacement: Center(child: CircularProgressIndicator()),
            child: Text("Current Step: ${controller.currentStep}, current songId: ${controller.songId}"),
          )),
    );

  }
}
