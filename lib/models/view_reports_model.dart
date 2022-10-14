// To parse this JSON data, do
//
//     final viewReports = viewReportsFromJson(jsonString);

import 'dart:convert';

List<ViewReports> viewReportsFromJson(String str) => List<ViewReports>.from(json.decode(str).map((x) => ViewReports.fromJson(x)));

String viewReportsToJson(List<ViewReports> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewReports {
    ViewReports({
        required this.songId,
        required this.verseNumber,
        required this.reportText,
        required this.reportStatus,
        required this.id,
    });

    String songId;
    String verseNumber;
    String reportText;
    String reportStatus;
    String id;

    factory ViewReports.fromJson(Map<String, dynamic> json) => ViewReports(
        songId: json["song_id"],
        verseNumber: json["verse_number"],
        reportText: json["report_text"],
        reportStatus: json["report_status"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "song_id": songId,
        "verse_number": verseNumber,
        "report_text": reportText,
        "report_status": reportStatus,
        "_id": id,
    };
}
