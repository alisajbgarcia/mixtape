import 'package:oauth2_client/oauth2_helper.dart';
//We are going to use the google client for this example...
import 'package:http/http.dart' as http;
import 'package:oauth2_client/oauth2_client.dart';

class SpotifyOAuth2Client extends OAuth2Client {
  SpotifyOAuth2Client({required String redirectUri, required String customUriScheme}): super(
      authorizeUrl: 'http://auth.localhost:8081/oauth2/authorize', //Your service's authorization url
      tokenUrl: 'http://auth.localhost:8081/oauth2/token', //Your service access token url
      redirectUri: redirectUri,
      customUriScheme: customUriScheme
  );
}
