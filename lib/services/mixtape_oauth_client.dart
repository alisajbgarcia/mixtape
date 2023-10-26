
import "package:oauth2_client/oauth2_client.dart";

class MixtapeOAuth2Client extends OAuth2Client {
  MixtapeOAuth2Client({required String redirectUri}): super(
    authorizeUrl: "https://auth.getmixtapeapplication.com/oauth2/authorize",
    tokenUrl: "https://auth.getmixtapeapplication.com/oauth2/token",
    redirectUri: redirectUri,
    customUriScheme: "com.mixtape",
  );
}