import 'dart:convert';
import 'package:http/http.dart';
import '../utilities/profile.dart';

class HttpService {
  final String profileURL = "http://localhost:8080/api/v1/getId";

  Future<Profile> getSpotifyProfile() async {
    Response res = await get(Uri.parse(profileURL));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      Profile p = new Profile("id", "spotifyUID", "DisplayName", "profilePicUrl");
      return p;
    } else {
      throw "Unable to retrieve profile data.";
    }
  }
}