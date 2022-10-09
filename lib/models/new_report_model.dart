// To parse this JSON data, do
//
//     final newReport = newReportFromJson(jsonString);

import 'dart:convert';

NewReport newReportFromJson(String str) => NewReport.fromJson(json.decode(str));

String newReportToJson(NewReport data) => json.encode(data.toJson());

class NewReport {
    NewReport({
        required this.songId,
        required this.verseNumber,
        required this.reportText,
        required this.reportStatus,
    });

    String songId;
    String verseNumber;
    String reportText;
    String reportStatus;

    factory NewReport.fromJson(Map<String, dynamic> json) => NewReport(
        songId: json["song_id"],
        verseNumber: json["verse_number"],
        reportText: json["report_text"],
        reportStatus: json["report_status"],
    );

    Map<String, dynamic> toJson() => {
        "song_id": songId,
        "verse_number": verseNumber,
        "report_text": reportText,
        "report_status": reportStatus,
    };
}
