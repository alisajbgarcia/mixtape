
import 'dart:convert';

import 'package:mixtape/models/json_serializable.dart';
import 'package:mixtape/models/profile.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/utilities/json_utilities.dart';

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
      // songs: List<TrackInfo>.of(json["songs"].map((item) => TrackInfo.fromJson(item))),
      songs: jsonDecodeList(json["songs"], TrackInfo.fromJson)
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

class MixtapeCreateDTO extends JsonSerializable {
  String name;
  String description;
  List<String> songIDs;

  MixtapeCreateDTO(this.name, this.description, this.songIDs);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "songIDs": jsonEncode(songIDs),
    };
  }
}
