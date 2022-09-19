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
          title: const Text('Projector'),
        ),
        body: Center(
          child: Text("Now playing song with id: ${controller.songId} and verse number: ${controller.verseNumber}"),
        ),
      ),
    );
  }
}