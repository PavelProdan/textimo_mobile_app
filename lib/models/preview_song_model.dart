// To parse this JSON data, do
//
//     final previewSong = previewSongFromJson(jsonString);

import 'dart:convert';

List<PreviewSong> previewSongFromJson(String str) => List<PreviewSong>.from(json.decode(str).map((x) => PreviewSong.fromJson(x)));

String previewSongToJson(List<PreviewSong> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreviewSong {
    PreviewSong({
        required this.songId,
        required this.lyricsText,
        required this.verseNumber,
        required this.id,
    });

    String songId;
    String lyricsText;
    int verseNumber;
    String id;

    factory PreviewSong.fromJson(Map<String, dynamic> json) => PreviewSong(
        songId: json["song_id"],
        lyricsText: json["lyrics_text"],
        verseNumber: json["verse_number"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "song_id": songId,
        "lyrics_text": lyricsText,
        "verse_number": verseNumber,
        "_id": id,
    };
}
