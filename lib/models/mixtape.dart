
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
  List<Reaction> reactions;


  Mixtape(
      {required this.id,
        required this.playlistID,
        required this.name,
        required this.createdAt,
        required this.description,
        required this.creator,
        required this.songIDs,
        required this.songs,
        required this.reactions});

  factory Mixtape.fromJson(Map<String, dynamic> json) {
    return Mixtape(
      id: json["id"],
      playlistID: json["playlistID"],
      name: json["name"],
      createdAt: DateTime.parse(json["createdAt"]),
      description: json["description"],
      creator: Profile.fromJson(json["creator"]),
      songIDs: List<String>.from(json['songIDs'].map((x) => x)),
      songs: jsonDecodeList(json["songs"], TrackInfo.fromJson),
      reactions: List<Reaction>.of(json["reactions"].map((item) => Reaction.fromJson(item)))
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
      "reactions": jsonEncode(reactions)
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
      "songIDs": songIDs,
    };
  }
}

enum ReactionType { LIKE, DISLIKE, HEART, FIRE}

class Reaction {
  int id;
  Profile reactor;
  ReactionType reactionType;

  Reaction(
      {required this.id,
        required this.reactor,
        required this.reactionType,});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "reactor": jsonEncode(this.reactor),
      "reactionType": this.reactionType.name,
    };
  }

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
        id: json["id"],
        reactor: Profile.fromJson(json["reactor"]),
        reactionType: json["reactionType"]
    );
  }


}
