// To parse this JSON data, do
//
//     final nowPlayingSong = nowPlayingSongFromJson(jsonString);

import 'dart:convert';

NowPlayingSong nowPlayingSongFromJson(String str) => NowPlayingSong.fromJson(json.decode(str));

String nowPlayingSongToJson(NowPlayingSong data) => json.encode(data.toJson());

class NowPlayingSong {
    NowPlayingSong({
        required this.id,
        required this.songId,
        required this.verseNumber,
    });

    String id;
    String songId;
    String verseNumber;

    factory NowPlayingSong.fromJson(Map<String, dynamic> json) => NowPlayingSong(
        id: json["_id"],
        songId: json["song_id"],
        verseNumber: json["verse_number"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "song_id": songId,
        "verse_number": verseNumber,
    };
}
