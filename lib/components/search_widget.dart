import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/models/song.dart';
import 'package:textimo_mobile_app/services/search_song_service.dart';
import 'package:textimo_mobile_app/models/now_playing_model.dart';
import 'package:textimo_mobile_app/models/song_single.dart';
import 'package:textimo_mobile_app/services/delete_song_service.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/views/projector.dart';
import 'package:textimo_mobile_app/views/home_page.dart';
import 'package:textimo_mobile_app/views/preview.dart';
import 'package:textimo_mobile_app/views/edit.dart';

class SearchSongDelegate extends SearchDelegate {
  List<Song> searched_songs = [];

  searchSongs(String query) async {
    final response = await SearchService().searchSong(query);
    if (response != null) {
      searched_songs = response;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchSongs(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (searched_songs.length == 0) {
            return Center(
              child: Text('Din pacate nu am gasit nici un rezultat'),
            );
          } else {
            return ListView.builder(
              itemCount: searched_songs.length,
              itemBuilder: (context, index) {
                
                return Card(
                    child: ListTile(
                  title: InkWell(
                    onTap: () async {
                      var data =
                          await Get.to(() => ProjectorWidget(), arguments: [
                        {"song_id": searched_songs[index].id},
                        {"verse_number": "1"}
                      ]);

                      if (data == "require_refresh") {
                        Get.offAll(() => HomePage());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(searched_songs[index].songTitle),
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String value) async {
                      if (value == "Afiseaza") {
                        var data =
                            await Get.to(() => ProjectorWidget(), arguments: [
                          {"song_id": searched_songs[index].id},
                          {"verse_number": "1"}
                        ]);

                        if (data == "require_refresh") {
                          Get.offAll(() => HomePage());
                        }
                      }
                      if (value == "Previzualizeaza") {
                        Get.to(() => PreviewWidget(), arguments: [
                          {"song_id": searched_songs[index].id},
                        ]);
                      }

                      if (value == "Modifica") {
                        Get.to(() => EditWidget(), arguments: [
                          {"song_id": searched_songs[index].id},
                        ]);
                      }

                      if (value == "Sterge") {
                        Get.defaultDialog(
                            title: 'Sterge "' +
                                searched_songs[index].songTitle +
                                '"',
                            middleText:
                                "Esti sigur ca vrei sa stergi aceasta melodie?",
                            textConfirm: "Da",
                            textCancel: "Nu",
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.black,
                            buttonColor: Colors.red,
                            onConfirm: () async {
                              final response = await DeleteSongService()
                                  .deleteSong(searched_songs[index].id);
                              if (response.statusCode == 200) {
                                Get.snackbar("Succes",
                                    "Melodia a fost stearsa cu succes!");
                                Get.offAll(() => HomePage());
                              } else {
                                Get.snackbar("Eroare",
                                    "A aparut o eroare la stergerea melodiei!");
                              }
                            },
                            onCancel: () {
                            });
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Afiseaza',
                        child: Text('Afișează'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Previzualizeaza',
                        child: Text('Previzualizează'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Modifica',
                        child: Text('Modifică'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Sterge',
                        child: Text('Șterge'),
                      ),
                    ],
                  ),
                ));
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(""),
    );
  }
}
