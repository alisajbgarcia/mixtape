
import 'dart:convert';

import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../models/friendship.dart';
import '../models/profile.dart';

class FriendshipService extends AbstractService {

  FriendshipService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<List<Friendship>> getFriendsForCurrentUser() async {
    return getMany("/api/v1/profile/me/playlist", Friendship.fromJson);
  }

  Future<void> acceptRequest(String friendshipId) async {
    return put("/api/v1/profile/me/friendship/$friendshipId/accept", null, Friendship.fromJson);
  }

  Future<void> deleteRequest(String friendshipId) async {
    return delete("/api/v1/profile/me/friendship/$friendshipId/deny");
  }

  Future<Friendship> createFriendRequest(String profileId) async {
    return postString("/api/v1/profile/me/friendship", jsonEncode(profileId), Friendship.fromJson);
  }
}