import 'dart:convert';
import 'dart:core';

class Profile {
  String id;
  String displayName;
  String spotifyUID;
  String profilePicURL;

  Profile(this.id, this.displayName, this.spotifyUID, this.profilePicURL);

  Profile.fromJson(Map<String, dynamic> items)
  : id = items["id"] as String,
    displayName = items["displayName"] as String,
    spotifyUID = items["spotifyUID"] as String,
    profilePicURL = items["profilePicURL"] as String;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "spotifyUID": spotifyUID,
      "profilePicURL": profilePicURL,
    };
  }
}