import 'dart:convert';
import 'dart:core';

import 'package:mixtape/models/profile.dart';

class Settings {
  String id;
  Profile profile;
  bool permissionNeededForPlaylists;
  List<Profile> friendsWithPermission;

  Settings({required this.id, required this.profile, required this.permissionNeededForPlaylists, required this.friendsWithPermission});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json["id"] ?? "",
      profile: Profile.fromJson(json["profile"]),
      permissionNeededForPlaylists: json["permissionNeededForPlaylists"] ?? false,
      friendsWithPermission: List<Profile>.from(json['friendsWithPermission'].map((x) => new Profile.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "profile": profile,
      "permissionNeededForPlaylists": permissionNeededForPlaylists,
      "friendsWithPermission": jsonEncode(friendsWithPermission),
    };
  }
}
