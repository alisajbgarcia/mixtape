
import 'dart:convert';

import 'package:mixtape/models/playlist.dart';

class FriendshipInfo {
  String friendId;
  List<Playlist> sharedPlaylists;
  int friendMixtapes;
  int userMixtapes;


  FriendshipInfo({required this.friendId,
    required this.sharedPlaylists,
    required this.friendMixtapes,
    required this.userMixtapes,});

  factory FriendshipInfo.fromJson(Map<String, dynamic> json) {
    return FriendshipInfo(
      friendId: json["friendId"],
      sharedPlaylists: List<Playlist>.from(json['sharedPlaylists'].map((x) => x)),
      friendMixtapes: json["friendMixtapes"],
      userMixtapes: json["userMixtapes"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "friendId": friendId,
      "sharedPlaylists": jsonEncode(sharedPlaylists),
      "friendMixtapes": friendMixtapes,
      "userMixtapes": userMixtapes,
    };
  }
}
