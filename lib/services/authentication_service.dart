
import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../models/profile.dart';

class AuthenticationService extends AbstractService {
  AuthenticationService(super.oauthClient, super.baseUrl);
  
  Future<bool> login() async {
    AccessTokenResponse response = await super.helper.fetchToken();

    if (!response.isValid()) {
      return false;
    }

    // Grab current profile
    Profile currentProfile = await super.get('/api/v1/profile/me', Profile.fromJson);

    // Enable debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.debug);

    // Initialize app
    OneSignal.initialize("ce9a6e81-4492-4d92-aa9f-cf2861d01632");

    // Login
    OneSignal.login(currentProfile.id);
    print(currentProfile.id);

    OneSignal.Notifications.requestPermission(true);

    return true;
  }

  Future<void> logout() async {
    await super.helper.removeAllTokens();
  }
}
