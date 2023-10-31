import 'package:image_picker/image_picker.dart';
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

  Future<Playlist> createPlaylistAndInvitation(Playlist playlist) async {
    return post<Playlist, Playlist>("/api/v1/profile/me/playlist", playlist, Playlist.fromJson);
  }

  Future<Playlist> setProfilePicForPlaylist(String playlistId, XFile uploadFile) {
    return putXFile("/api/v1/profile/me/playlist/$playlistId/cover-pic", uploadFile, "file", Playlist.fromJson);
  }
}
