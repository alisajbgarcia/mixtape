
import 'dart:convert';

import 'package:mixtape/models/mixtape.dart';
import 'package:mixtape/models/playlist.dart';
import 'package:mixtape/services/abstract_service.dart';

class MixtapeService extends AbstractService {
  MixtapeService(super.helper, super.baseUrl);

  Future<List<Mixtape>> getMixtapesForPlaylistCurrentUser(String playlistId) async {
    return getMany("/api/v1/profile/me/playlist/$playlistId/mixtape", Mixtape.fromJson);
  }

  Future<List<Mixtape>> getMixtapesbyTapeForPlaylistCurrentUser(String playlistId, String query) async {
    return getMany("/api/v1/profile/me/playlist/$playlistId/mixtape?title=$query", Mixtape.fromJson);
  }

  Future<List<Mixtape>> getMixtapesbySongForPlaylistCurrentUser(String playlistId, String query) async {
    return getMany("/api/v1/profile/me/playlist/$playlistId/mixtape?songName=$query", Mixtape.fromJson);
  }

  Future<List<Mixtape>> getMixtapesbyArtistForPlaylistCurrentUser(String playlistId, String query) async {
    return getMany("/api/v1/profile/me/playlist/$playlistId/mixtape?artistName=$query", Mixtape.fromJson);
  }

  Future<List<Mixtape>> getMixtapesbyAlbumForPlaylistCurrentUser(String playlistId, String query) async {
    return getMany("/api/v1/profile/me/playlist/$playlistId/mixtape?albumName=$query", Mixtape.fromJson);
  }

  Future<Mixtape> getMixtapeInPlaylistCurrentUser(String playlistId, String mixtapeId) async {
    return get("/api/v1/profile/me/playlist/$playlistId/mixtape/$mixtapeId", Mixtape.fromJson);
  }

  Future<Mixtape> createMixtapeInPlaylistForCurrentUser(String playlistId, {required String name, required String description, required List<String> songIDs}) async {
    final createDTO = MixtapeCreateDTO(name, description, songIDs);
    return post("/api/v1/profile/me/playlist/$playlistId/mixtape", createDTO, Mixtape.fromJson);
  }

  Future<void> deleteMixtapeInPlaylistForCurrentUser(String playlistId, String mixtapeId) async {
    return delete("/api/v1/profile/me/playlist/$playlistId/mixtape/$mixtapeId");
  }

  Future<Mixtape> addReactionForCurrentUser(String playlistId, String mixtapeId, {required String type}) {
    print(type);
    return putString("/api/v1/profile/me/playlist/$playlistId/mixtape/$mixtapeId/reaction", jsonEncode(type), Mixtape.fromJson);
  }
}
