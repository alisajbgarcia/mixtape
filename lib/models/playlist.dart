import 'dart:convert';

import 'package:mixtape/models/profile.dart';

import 'mixtape.dart';

class Playlist {
  String id;
  String spotifyID; // unused :(
  String name;
  Profile initiator;
  Profile target;
  String description;
  String coverPicURL;

  List<Mixtape> mixtapes;

  Playlist(
      {required this.id,
      required this.spotifyID,
      required this.name,
      required this.initiator,
      required this.target,
      required this.description,
      required this.coverPicURL,
      required this.mixtapes});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json["id"],
      spotifyID: json["spotifyID"],
      name: json["name"],
      initiator: Profile.fromJson(json["initiator"]),
      target: Profile.fromJson(json["target"]),
      description: json["description"],
      coverPicURL: json["coverPicURL"],
      mixtapes: List<Mixtape>.of(json["mixtapes"].map((item) => Mixtape.fromJson(item))),
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