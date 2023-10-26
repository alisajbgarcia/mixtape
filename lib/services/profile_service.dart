
import 'dart:convert';

import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:http/http.dart';

import '../models/profile.dart';

class ProfileService {

  final OAuth2Helper helper;
  final String baseURL;

  ProfileService(this.helper, this.baseURL);

  Future<bool> login() async {
    AccessTokenResponse response = await helper.fetchToken();
    return response.isValid();
  }

  Future<Profile> getCurrentProfile() async {
    Response response = await helper.get('$baseURL/api/v1/profile/me');
    if (response.statusCode != 200) {
      return Future.error("Network status failed: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return Profile.fromJson(jsonDecode(response.body));
  }
}
