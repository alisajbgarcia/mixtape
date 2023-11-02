import 'dart:convert';
import 'dart:core';

import 'package:mixtape/models/profile.dart';

class Notif {
  String id;
  Profile target; 
  Profile initiator;
  String externalId;

  Notif(
      { required this.id,
        required this.initiator,
        required this.target,
        required this.externalId});

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json["id"],
      initiator: Profile.fromJson(json["initiator"]),
      target: Profile.fromJson(json["target"]),
      externalId: json["externalId"],
    );
  }

}