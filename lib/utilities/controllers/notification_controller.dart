import 'package:flutter/material.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/friendship_service.dart';
import 'package:mixtape/services/mixtape_service.dart';
import 'package:mixtape/services/notification_service.dart';
import 'package:mixtape/services/playlist_service.dart';
import 'package:mixtape/services/profile_service.dart';

import '../../models/friendship.dart';
import '../../models/notification.dart';
import '../../models/playlist.dart';
import '../../models/profile.dart';
import '../../services/services_container.dart';

//Base Controller concept
class BusinessController {
  final BuildContext context;
  late FriendshipService _friendshipService;
  late NotificationService _notificationService;
  late PlaylistService _playlistService;
  late ProfileService _profileService;

  
  BusinessController({required this.context}) { 
    _friendshipService = ServicesContainer.of(context).friendshipService;
    _notificationService = ServicesContainer.of(context).notificationService; 
    _playlistService = ServicesContainer.of(context).playlistService; 
    _profileService = ServicesContainer.of(context).profileService;   
  }

  //Basic
  Future<List<Notif>> getNotifications() {
    return _notificationService.getNotifications();
  }
  Future<Profile> getCurrentProfile() {
    return _profileService.getCurrentProfile();
  }

  //Friend Notifs
  Future<void> acceptFriend(String friendshipId) {
    return _friendshipService.acceptRequest(friendshipId);
  }
  Future<void> denyFriend(String friendshipId) {
    return _friendshipService.deleteRequest(friendshipId);
  }

  //Playlist Notifs
  Future<void> acceptPlaylist(String playlistId) {
    return _playlistService.acceptRequest(playlistId);
  }
  Future<void> deletePlaylist(String playlistId) {
    return _playlistService.deleteRequest(playlistId);
  }

  //Activity Notifs
  Future<Playlist> getPlaylist(playlistId) {
    return _playlistService.getPlaylistForCurrentUser(playlistId);
  }
}