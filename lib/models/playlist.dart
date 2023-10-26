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
}