import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/services/get_reports_service.dart';
import 'package:textimo_mobile_app/services/update_report_status_service.dart';
import 'package:textimo_mobile_app/services/get_details_song_service.dart';
import 'package:textimo_mobile_app/models/view_reports_model.dart';

const List<String> list = <String>['Raportări în lucru', 'Toate raportările'];

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String dropdownValue = list.first;
  bool isLoaded = false;
  List<ViewReports> reports = [];

  @override
  void initState() {
    super.initState();

    getReports(dropdownValue);
  }

  getReports(String dropdownVal) async {
    if (dropdownVal == 'Raportări în lucru') {
      var response = await GetAllReports().getAllReports();
      if (response != null) {
        for (int i = 0; i < response.length; i++) {
          var song_name = await GetSongInfo().getSongInfo(response[i].songId);
          if (song_name != null) {
            response[i].songId = song_name.songTitle;
          }
        }
        setState(() {
          reports = response;
          isLoaded = true;
        });
      }
    } else {
      setState(() {
        isLoaded = true;
      });
      Get.snackbar("Atentie!", "Se pare ca a aparut o eroare.");
    }
  }

  bool CheckIfVisible(String DropdownValue, String status) {
    if (status == 'Nou' && DropdownValue == 'Raportări în lucru') {
      return true;
    } else if (DropdownValue == 'Toate raportările') {
      return true;
    } else {
      return false;
    }
  }

  void updateReport(String reportId) async {
    var response = await UpdateReportService().updateReportStatus(reportId);
    if(response.statusCode == 200){
      Get.snackbar("Succes!", "Raportul a fost marcat ca rezolvat.");
      getReports(dropdownValue);
    } else {
      Get.snackbar("Atentie!", "Se pare ca a aparut o eroare.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raportări deschise'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Color(0xFF3F63F1)),
                  underline: Container(
                    height: 2,
                    color: const Color(0xFF3F63F1),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                // implement a list builder
                Expanded(
                  child: ListView.builder(
                    itemCount: reports.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Visibility(
                        visible: CheckIfVisible(
                            dropdownValue, reports[index].reportStatus),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 5.0, 5.0, 4.0),
                                        child: Text(
                                          reports[index].songId +
                                              ", strofa " +
                                              reports[index].verseNumber,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                          onLongPress: () => {
                                                Get.defaultDialog(
                                                    title: 'Actualizare status '+reports[index].songId,
                                                    middleText:
                                                        "Esti sigur ca vrei sa marchezi ca rezolvat?",
                                                    textConfirm: "Da",
                                                    textCancel: "Nu",
                                                    confirmTextColor:
                                                        Colors.white,
                                                    cancelTextColor:
                                                        Colors.black,
                                                    buttonColor: Colors.red,
                                                    onConfirm: () async {
                                                      updateReport(reports[index].id);
                                                      Navigator.pop(context);
                                                    },
                                                    onCancel: () {
                                                    })
                                              },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12.0, 5.0, 5.0, 4.0),
                                            child: Text(
                                              reports[index].reportText,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          reports[index].reportStatus,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                height: 2.0,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
