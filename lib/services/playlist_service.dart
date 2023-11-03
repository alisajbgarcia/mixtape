import 'package:image_picker/image_picker.dart';
import 'package:mixtape/models/json_serializable.dart';
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

  Future<CreatePlaylistResponse> createPlaylistAndInvitation(CreatePlaylistDTO playlist) async {
    return post<CreatePlaylistDTO, CreatePlaylistResponse>("/api/v1/profile/me/playlist", playlist, CreatePlaylistResponse.fromJson);
  }

  Future<CreatePlaylistResponse> setProfilePicForPlaylist(String playlistId, XFile uploadFile) {
    return putXFile("/api/v1/profile/me/playlist/$playlistId/cover-pic", uploadFile, "file", CreatePlaylistResponse.fromJson);
  }

  Future<Playlist> createPlaylistForCurrentUser({required String name, required String description, required String coverPicURL, required String requestedUserID}) async {
    final createDTO = CreatePlaylistDTO(name, description, coverPicURL, requestedUserID);
    return post("/api/v1/profile/me/playlist", createDTO, Playlist.fromJson);
  }

  Future<void> deletePlaylist(String playlistId) async {
    return delete("/api/v1/profile/me/playlist/$playlistId");
  }

  Future<void> acceptRequest(String playlistId) async {
    return put("/api/v1/profile/me/playlist/$playlistId/accept", null, Playlist.fromJson);
  }

  Future<void> deleteRequest(String playlistId) async {
    return delete("/api/v1/profile/me/playlist/$playlistId/deny");
  }
}
