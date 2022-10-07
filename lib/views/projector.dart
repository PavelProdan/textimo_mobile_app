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
            title: Text("Proiecție Live"),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F63F1),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.hide_source),
                  tooltip: 'Opreste proiecția',
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
                  child: Text(
                      "Strofa curentă: ${controller.verseNumber} din ${nowPlayingSongDetails?.totalNumLyrics ?? ''}",
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
                      child: Text(
                          "jhfjdfhjhfdjdhfjhdf \nyfdjyfjdy\ngfshdhgfdhdgfhdgfhdgfhdfhgdf\ndfhjdhfjhdfj\njdfjdfjgdf\njhsjdj",
                          style: TextStyle(color: Colors.black, fontSize: 18))),
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
                    onTap: () {},
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
                    onTap: () {},
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
                              TextSpan(text: 'Strofa următoare'),
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
