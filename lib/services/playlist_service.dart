import 'dart:convert';

import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:http/http.dart';

import '../models/playlist.dart';

class PlaylistService {

  final OAuth2Helper helper;
  final String baseURL;

  PlaylistService(this.helper, this.baseURL);

  Future<bool> login() async {
    AccessTokenResponse response = await helper.fetchToken();
    return response.isValid();
  }

  Future<Playlist> getCurrentProfile() async {
    Response response = await helper.get('$baseURL/api/v1/profile/me');
    if (response.statusCode != 200) {
      return Future.error("Network status failed: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return Playlist.fromJson(jsonDecode(response.body));
  }
}
