
import 'dart:convert';

import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../models/profile.dart';
import '../models/settings.dart';

class ProfileService extends AbstractService {

  ProfileService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<Profile> getCurrentProfile() async {
    return super.get("/api/v1/profile/me", Profile.fromJson);
  }

  Future<Profile> getProfileById(String profileId) async {
    return super.get("/api/v1/profile/${profileId}", Profile.fromJson);
  }

  Future<List<Profile>> getFriendsForCurrentUser() async {
    return getMany("/api/v1/profile/me/friendship/friends", Profile.fromJson);
  }

  Future<List<Profile>> searchProfiles(String displayName) async {
    return getMany("/api/v1/profile", Profile.fromJson, paramMap: Map.fromEntries([MapEntry("displayName", displayName)]));
  }

  Future<List<Profile>> getBlockedProfilesForCurrentUser() async {
    return getMany("/api/v1/profile/me/blocklist", Profile.fromJson);
  }

  Future<Settings> getProfileSettings() async {
    print("IN PROFILE SETTINGS");
    return get("/api/v1/profile/me/settings", Settings.fromJson);
  }

  Future<Settings> updateProfileSettingsPermission(bool value) {
    return put("/api/v1/profile/me/settings?isPermissionNeededForPlaylists=${value}", null, Settings.fromJson);
  }

  Future<Settings> addApprovedFriend(String friendId) {
    print("ADDING APPROVED FRIEND");
    return put("/api/v1/profile/me/settings/${friendId}", null, Settings.fromJson);
  }

}
