
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class AuthenticationService {
  OAuth2Helper oauthClient;
  
  AuthenticationService(this.oauthClient);
  
  Future<bool> login() async {
    AccessTokenResponse response = await oauthClient.fetchToken();
    return response.isValid();
  }

  Future<void> logout() async {
    await oauthClient.removeAllTokens();
  }
}
