import 'package:mixtape/models/playlist.dart';
import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class PlaylistService extends AbstractService {
  PlaylistService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<List<Playlist>> getPlaylistsForCurrentUser() async {
    return getMany("/api/v1/profile/me/playlist", Playlist.fromJson);
  }

  Future<Playlist> getPlaylistForCurrentUser(String playlistId) async {
    return get("/api/v1/profile/me/playlist/$playlistId", Playlist.fromJson);
  }
}
