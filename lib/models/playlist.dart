import 'dart:convert';

import 'package:mixtape/models/json_serializable.dart';
import 'package:mixtape/models/profile.dart';

import '../utilities/json_utilities.dart';
import 'mixtape.dart';

class Playlist implements JsonSerializable{
  String id;
  String spotifyID; // unused :(
  String name;
  Profile initiator;
  Profile target;
  String description;
  String coverPicURL;
  int totalDurationMS;
  int songCount;

  List<Mixtape> mixtapes;

  Playlist(
      {required this.id,
      required this.spotifyID,
      required this.name,
      required this.initiator,
      required this.target,
      required this.description,
      required this.coverPicURL,
      required this.mixtapes,
      required this.totalDurationMS,
      required this.songCount});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json["id"],
      spotifyID: json["spotifyID"] ?? "",
      name: json["name"],
      initiator: Profile.fromJson(json["initiator"]),
      target: Profile.fromJson(json["target"]),
      description: json["description"] ?? "",
      coverPicURL: json["coverPicURL"] ?? "",
      mixtapes: jsonDecodeList(json["mixtapes"], Mixtape.fromJson),
      totalDurationMS: json["totalDurationMS"],
      songCount: json["songCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "spotifyID": spotifyID,
      "name": name,
      "initiator": initiator,
      "target": target,
      "description": description,
      "coverPicURL": coverPicURL,
      "mixtapes": jsonEncode(mixtapes),
    };
  }

//
}

class CreatePlaylistResponse implements JsonSerializable{
  String id;
  String spotifyID; // unused :(
  String name;
  Profile initiator;
  Profile? target;
  String description;
  String coverPicURL;
  int totalDurationMS;
  int songCount;

  List<Mixtape> mixtapes;

  CreatePlaylistResponse(
      {required this.id,
        required this.spotifyID,
        required this.name,
        required this.initiator,
        required this.description,
        required this.coverPicURL,
        required this.mixtapes,
        required this.totalDurationMS,
        required this.songCount});

  factory CreatePlaylistResponse.fromJson(Map<String, dynamic> json) {
    return CreatePlaylistResponse(
      id: json["id"],
      spotifyID: json["spotifyID"] ?? "",
      name: json["name"],
      initiator: Profile.fromJson(json["initiator"]),
      description: json["description"] ?? "",
      coverPicURL: json["coverPicURL"] ?? "",
      mixtapes: jsonDecodeList(json["mixtapes"], Mixtape.fromJson),
      totalDurationMS: json["totalDurationMS"],
      songCount: json["songCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "spotifyID": spotifyID,
      "name": name,
      "initiator": initiator,
      "target": target,
      "description": description,
      "coverPicURL": coverPicURL,
      "mixtapes": jsonEncode(mixtapes),
    };
  }

//
}

class CreatePlaylistDTO extends JsonSerializable {
  String name;
  String description;
  String coverPicURL; // not sure how this will work quite yet…
  String requestedUserID;

  CreatePlaylistDTO(this.name, this.description, this.coverPicURL, this.requestedUserID);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "coverPicURL": coverPicURL,
      "requestedUserID": requestedUserID,
    };
  }
}