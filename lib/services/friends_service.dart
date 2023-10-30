
import 'package:mixtape/services/abstract_service.dart';

import '../models/profile.dart';

class FriendsService extends AbstractService {

  FriendsService(super.helper, super.baseUrl);

  Future<List<Profile>> getFriendsForCurrentUser() async {
    return getMany("/api/v1/profile/me/friendship/friends", Profile.fromJson);
  }
}