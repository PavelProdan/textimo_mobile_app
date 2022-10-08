// To parse this JSON data, do
//
//     final projector = projectorFromJson(jsonString);

import 'dart:convert';

Projector projectorFromJson(String str) => Projector.fromJson(json.decode(str));

String projectorToJson(Projector data) => json.encode(data.toJson());

class Projector {
    Projector({
        required this.liveData,
        required this.songId,
        required this.verseNumber,
    });

    String liveData;
    String songId;
    String verseNumber;

    factory Projector.fromJson(Map<String, dynamic> json) => Projector(
        liveData: json["live_data"],
        songId: json["song_id"],
        verseNumber: json["verse_number"],
    );

    Map<String, dynamic> toJson() => {
        "live_data": liveData,
        "song_id": songId,
        "verse_number": verseNumber,
    };
}
