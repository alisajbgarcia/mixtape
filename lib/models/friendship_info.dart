
import 'dart:convert';

import 'package:mixtape/models/playlist.dart';

class FriendshipInfo {
  List<Playlist> sharedPlaylists;
  int numMixtapesFromProfile;
  int numMixtapesFromFriend;


  FriendshipInfo({
    required this.sharedPlaylists,
    required this.numMixtapesFromProfile,
    required this.numMixtapesFromFriend,});

  factory FriendshipInfo.fromJson(Map<String, dynamic> json) {
    return FriendshipInfo(
      sharedPlaylists: List<Playlist>.from(json['sharedPlaylists'].map((x) => x)),
      numMixtapesFromProfile: json["numMixtapesFromProfile"],
      numMixtapesFromFriend: json["userMixtapes"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sharedPlaylists": jsonEncode(sharedPlaylists),
      "numMixtapesFromProfile": numMixtapesFromProfile,
      "userMixtapes": numMixtapesFromFriend,
    };
  }
}
