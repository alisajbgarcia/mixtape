import 'package:flutter/material.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/friendship_service.dart';
import 'package:mixtape/services/mixtape_service.dart';
import 'package:mixtape/services/notification_service.dart';
import 'package:mixtape/services/playlist_service.dart';
import 'package:mixtape/services/profile_service.dart';

import '../../models/friendship.dart';
import '../../services/services_container.dart';

//Base Controller concept
class BusinessController {
  final BuildContext context;
  late AuthenticationService _authenticationService;
  late FriendshipService _friendshipService;
  late MixtapeService _mixtapeService;
  late NotificationService _notificationService;
  late PlaylistService _playlistService;
  late ProfileService _profileService;

  
  BusinessController({required this.context}) {
    _authenticationService = ServicesContainer.of(context).authService;  
    _friendshipService = ServicesContainer.of(context).friendshipService; 
    _mixtapeService = ServicesContainer.of(context).mixtapeService; 
    _notificationService = ServicesContainer.of(context).notificationService; 
    _playlistService = ServicesContainer.of(context).playlistService; 
    _profileService = ServicesContainer.of(context).profileService;   
  }

  // AuthenticationService get authenticationService => _authenticationService;
  // FriendshipService get friendshipService => _friendshipService;
  // MixtapeService get mixtapeService => _mixtapeService;
  // NotificationService get notificationService => _notificationService;
  // PlaylistService get playlistService => _playlistService;
  // ProfileService get profileService => _profileService;

  //Auth Service
  // Future<bool> login() {
  //   return _authenticationService.login();
  // }
  // Future<void> logout() {
  //   return _authenticationService.logout();
  // }
}