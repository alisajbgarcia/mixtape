import 'dart:core';

class Profile {
  String id;
  String displayName;
  String spotifyUID;
  String profilePicURL;
  bool onboarded;

  Profile(this.id, this.displayName, this.spotifyUID, this.profilePicURL, this.onboarded  );

  Profile.fromJson(Map<String, dynamic> items)
  : id = items["id"],
    displayName = items["displayName"] ?? "",
    spotifyUID = items["spotifyUID"] ?? "",
    profilePicURL = items["profilePicURL"] ?? "",
    onboarded = items["onboarded"]
  ;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "spotifyUID": spotifyUID,
      "profilePicURL": profilePicURL,
    };
  }
}
