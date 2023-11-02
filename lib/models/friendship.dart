import 'dart:core';

import 'package:mixtape/models/profile.dart';

class Friendship {
  String id;
  Profile initiator;
  Profile target;

  Friendship(
      {required this.id,
        required this.initiator,
        required this.target,});

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json["id"],
      initiator: Profile.fromJson(json["initiator"]),
      target: Profile.fromJson(json["target"]),
    );
  }
}