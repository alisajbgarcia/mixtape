
import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../models/friendship.dart';
import '../models/profile.dart';

class FriendshipService extends AbstractService {

  FriendshipService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<List<Friendship>> getFriendsForCurrentUser() async {
    return getMany("/api/v1/profile/me/playlist", Friendship.fromJson);
  }

}