// To parse this JSON data, do
//
//     final song = songFromJson(jsonString);

import 'dart:convert';

List<Song> songFromJson(String str) => List<Song>.from(json.decode(str).map((x) => Song.fromJson(x)));

String songToJson(List<Song> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Song {
    Song({
        required this.songTitle,
        required this.totalNumLyrics,
        required this.id,
    });

    String songTitle;
    dynamic totalNumLyrics;
    String id;

    factory Song.fromJson(Map<String, dynamic> json) => Song(
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
