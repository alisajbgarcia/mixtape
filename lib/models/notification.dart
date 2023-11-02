import 'dart:convert';
import 'dart:core';

import 'package:mixtape/models/profile.dart';

enum NotificationType {MIXTAPE, FRIENDSHIP, PLAYLIST}

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
      notificationType: json["notificationType"],
      contents: json["contents"],
    );
  }

}