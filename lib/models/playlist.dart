import 'package:mixtape/models/profile.dart';

import 'mixtape.dart';

class Playlist {
  String id;
  String spotifyID; // unused :(
  String name;
  Profile initiator;
  String description;
  String coverPicURL;

  List<Mixtape> mixtapes;

  Playlist(this.id, this.spotifyID, this.name, this.initiator,
      this.description, this.coverPicURL, this.mixtapes);

  Playlist.fromJson(Map<String, dynamic> items)
      : id = items["id"] as String,
        spotifyID = items["spotifyID"] as String,
        name = items["name"] as String,
        initiator = items["initiator"] as Profile,
        description = items["description"] as String,
        coverPicURL = items["coverPicURL"] as String,
        mixtapes = items["mixtapes"] as List<Mixtape>;
}