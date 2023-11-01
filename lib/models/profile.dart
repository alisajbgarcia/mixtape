import 'dart:core';

class Profile {
  String id;
  String displayName;
  String spotifyUID;
  String profilePicURL;

  Profile(this.id, this.displayName, this.spotifyUID, this.profilePicURL);

  Profile.fromJson(Map<String, dynamic> items)
  : id = items["id"],
    displayName = items["displayName"] ?? "",
    spotifyUID = items["spotifyUID"] ?? "",
    profilePicURL = items["profilePicURL"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "spotifyUID": spotifyUID,
      "profilePicURL": profilePicURL,
    };
  }
}
