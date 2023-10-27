
import 'dart:convert';

import 'package:mixtape/models/profile.dart';
import 'package:mixtape/models/track_info.dart';

class Mixtape {
  String id;
  String playlistID;
  String name;
  DateTime createdAt;
  String description;
  Profile creator;
  List<String> songIDs;
  List<TrackInfo> songs;

  Mixtape(
      {required this.id,
        required this.playlistID,
        required this.name,
        required this.createdAt,
        required this.description,
        required this.creator,
        required this.songIDs,
        required this.songs});

  factory Mixtape.fromJson(Map<String, dynamic> json) {
    return Mixtape(
      id: json["id"],
      playlistID: json["playlistID"],
      name: json["name"],
      createdAt: DateTime.parse(json["createdAt"]),
      description: json["description"],
      creator: Profile.fromJson(json["creator"]),
      songIDs: List<String>.of(json["songIDs"].map((item) => item)),
      songs: List<TrackInfo>.of(json["songs"].map((item) => TrackInfo.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "playlistID": playlistID,
      "name": name,
      "createdAt": createdAt.toIso8601String(),
      "description": description,
      "creator": creator,
      "songIDs": jsonEncode(songIDs),
      "songs": jsonEncode(songs),
    };
  }
}
