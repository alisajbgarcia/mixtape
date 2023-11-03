import 'dart:convert';
import 'dart:core';
import 'package:mixtape/utilities/json_utilities.dart';
import 'package:mixtape/models/profile.dart';

enum NotificationType {
  MIXTAPE, FRIENDSHIP, PLAYLIST;

  String toJson() => name;
  static NotificationType fromJson(String json) => values.byName(json);
  }

class Notif {
  String id;
  Profile target; 
  String externalId;
  String contents;
  NotificationType notificationType;


  Notif(
      { required this.id,
        required this.target,
        required this.externalId,
        required this.notificationType,
        required this.contents
        });

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json["id"],
      target: Profile.fromJson(json["target"]),
      externalId: json["externalId"],
      notificationType: NotificationType.fromJson(json["notificationType"]),
      contents: json["contents"],
    );
  }

}