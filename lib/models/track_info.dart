
import 'dart:convert';

class TrackInfo {
  String id;
  String name;
  List<String> artistNames;
  String albumName;
  String albumImageURL;


  TrackInfo({required this.id,
      required this.name,
      required this.artistNames,
      required this.albumName,
      required this.albumImageURL});

  factory TrackInfo.fromJson(Map<String, dynamic> json) {
    return TrackInfo(
      id: json["id"],
      name: json["name"],
      artistNames: List<String>.from(json['artistNames'].map((x) => x)),
      albumName: json["albumName"],
      albumImageURL: json["albumImageURL"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "artistNames": jsonEncode(artistNames),
      "albumName": albumName,
      "albumImageURL": albumImageURL,
    };
  }
}
