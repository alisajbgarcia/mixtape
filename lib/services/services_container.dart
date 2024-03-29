import 'package:flutter/widgets.dart';
import 'package:mixtape/services/friendship_service.dart';
import 'package:mixtape/services/mixtape_oauth_client.dart';
import 'package:mixtape/services/playlist_service.dart';
import 'package:mixtape/services/profile_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'authentication_service.dart';
import 'mixtape_service.dart';
import 'notification_service.dart';


class ServicesContainer {
  AuthenticationService authService;
  MixtapeService mixtapeService;
  ProfileService profileService;
  PlaylistService playlistService;
  NotificationService notificationService;
  FriendshipService friendshipService;

  
  ServicesContainer(this.authService, this.mixtapeService, this.profileService, 
        this.notificationService, this.playlistService, this.friendshipService);

  static Future<ServicesContainer> initialize({String baseUrl = "https://api.getmixtapeapplication.com"}) async {
    final mixtapeClientSpec = MixtapeOAuth2Client(redirectUri: 'com.mixtape://callback');
    final helper = OAuth2Helper(
      mixtapeClientSpec,
      clientId: 'mixtape-flutter',
      clientSecret: 'secret',
      grantType: OAuth2Helper.authorizationCode,
      scopes: ['profile', 'openid']
    );

    final authService = AuthenticationService(helper, baseUrl);
    final mixtapeService = MixtapeService(helper, baseUrl);
    final profileService = ProfileService(helper, baseUrl);
    final playlistService = PlaylistService(helper, baseUrl);
    final notificationService = NotificationService(helper, baseUrl);
    final friendshipService = FriendshipService(helper, baseUrl);

    
    return ServicesContainer(authService, mixtapeService, profileService, notificationService, playlistService, friendshipService);

  }

  static ServicesContainer of(BuildContext context) {
    // A bit different from a normal inherited widget. Widgets can call this from initState,
    // and it is assumed that the services never change during the lifetime of the app
    final provider = context.getElementForInheritedWidgetOfExactType<ServicesProvider>()?.widget as ServicesProvider;
    return provider.services;
  }
}

class ServicesProvider extends InheritedWidget {
  final ServicesContainer services;

  const ServicesProvider({super.key, required this.services, required super.child});

  @override
  bool updateShouldNotify(ServicesProvider old) {
    if (services != old.services) {
      throw Exception('Services must be constant!');
    }
    return false;
  }
}
