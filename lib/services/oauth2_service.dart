import 'package:oauth2_client/oauth2_helper.dart';
//We are going to use the google client for this example...
import 'package:http/http.dart' as http;
import 'package:oauth2_client/oauth2_client.dart';

class SpotifyOAuth2Client extends OAuth2Client {
  SpotifyOAuth2Client({required String redirectUri, required String customUriScheme}): super(
      authorizeUrl: 'http://localhost:9000/oauth2/authorize', //Your service's authorization url
      tokenUrl: 'http://localhost:9000/oauth2/token', //Your service access token url
      redirectUri: redirectUri,
      customUriScheme: customUriScheme
  );
}

// OAuth2Client client = SpotifyOAuth2Client(
//     redirectUri: "com.mixtape//callback", customUriScheme: "com.mixtape");
//
// //Then, instantiate the helper passing the previously instantiated client
// OAuth2Helper oauth2Helper = OAuth2Helper(client,
//     grantType: OAuth2Helper.authorizationCode,
//     clientId: 'spotify-client',
//     clientSecret: 'secret',
//     scopes: ['profile', 'openid']);

