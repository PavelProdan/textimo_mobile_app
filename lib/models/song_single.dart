// To parse this JSON data, do
//
//     final songSingle = songSingleFromJson(jsonString);

import 'dart:convert';

SongSingle songSingleFromJson(String str) => SongSingle.fromJson(json.decode(str));

String songSingleToJson(SongSingle data) => json.encode(data.toJson());

class SongSingle {
    SongSingle({
        required this.songTitle,
        required this.totalNumLyrics,
        required this.id,
    });

    String songTitle;
    String totalNumLyrics;
    String id;

    factory SongSingle.fromJson(Map<String, dynamic> json) => SongSingle(
        songTitle: json["song_title"],
        totalNumLyrics: json["total_num_lyrics"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "song_title": songTitle,
        "total_num_lyrics": totalNumLyrics,
        "_id": id,
    };
}
