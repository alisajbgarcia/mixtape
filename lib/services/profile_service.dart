
import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../models/profile.dart';

class ProfileService extends AbstractService {

  ProfileService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<Profile> getCurrentProfile() async {
    return super.get("/api/v1/profile/me", Profile.fromJson);
  }

}
