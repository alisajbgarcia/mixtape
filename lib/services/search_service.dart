import 'package:mixtape/models/playlist.dart';
import 'package:mixtape/models/mixtape.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class SearchService extends AbstractService {
  SearchService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<List<TrackInfo>> getRecentlyListened() async {
    return getMany("/api/v1/profile/me/search/recent-tracks", TrackInfo.fromJson);
  }

}
