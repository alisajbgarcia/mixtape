
class Mixtape {
  String id;
  String playlistID;
  String name;
  String description;
  String creatorID;
  String parentPlaylistID;
  // TODO this will change to a song info model or something...
  List<String> songIDs;

  Mixtape(this.id, this.playlistID, this.name, this.description, this.creatorID,
      this.parentPlaylistID, this.songIDs);
}
