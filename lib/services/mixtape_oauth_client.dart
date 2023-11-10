
import "package:oauth2_client/oauth2_client.dart";

class MixtapeOAuth2Client extends OAuth2Client {
  MixtapeOAuth2Client({required String redirectUri}): super(
    authorizeUrl: "https://auth.getmixtapeapplication.com/oauth2/authorize",
    tokenUrl: "https://auth.getmixtapeapplication.com/oauth2/token",
    redirectUri: redirectUri,
    customUriScheme: "com.mixtape",
  );
}

class LocalMixtapeOAuth2Client extends OAuth2Client {
  LocalMixtapeOAuth2Client({required String redirectUri}): super(
    authorizeUrl: "http://auth.mixtape.local:9000/oauth2/authorize",
    tokenUrl: "http://auth.mixtape.local:9000/oauth2/token",
    redirectUri: redirectUri,
    customUriScheme: "com.mixtape",
  );
}
