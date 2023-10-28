
import 'dart:convert';
import 'dart:io';

import 'package:mixtape/models/json_serializable.dart';
import 'package:oauth2_client/oauth2_helper.dart';

/// Provides common network actions for interfaces. Basically, use the http
/// methods provided here. They make things easier. They provide some error
/// handling and automatic parsing on entities.
class AbstractService {
  OAuth2Helper helper;
  String baseUrl;

  AbstractService(this.helper, this.baseUrl);

  /// Performs a GET request on a URI relative to the base url provided. The
  /// provided parserFactory converts the parsed JSON body into an object
  /// of your choice. The value is returned from the response
  ///
  /// example usage:
  /// get('/api/v1/profile/me/playlist/playlistId', Playlist.fromJson)
  Future<T> get<T>(String uri, T Function(Map<String, dynamic>) parserFactory) async {
    // remove starting '/' if necessary
    uri = _sanitizeUri(uri);

    final response = await helper.get("$baseUrl/$uri");
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeSingle(response.body, parserFactory);
  }

  /// Like get, except return a list of items. the parser factory parses each
  /// item in the list
  Future<List<T>> getMany<T>(String uri, T Function(Map<String, dynamic>) parserFactory) async {
    uri = _sanitizeUri(uri);

    final response = await helper.get("$baseUrl/$uri");
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeMany(response.body, parserFactory);
  }

  Future<R> post<T extends JsonSerializable, R>(String uri, T body, R Function(Map<String, dynamic>) responseConverter) async {
    uri = _sanitizeUri(uri);
    final bodyMap = body.toJson();

    final response = await helper.post("$baseUrl/$uri", body: bodyMap, headers: { HttpHeaders.contentTypeHeader: ContentType.json.mimeType });
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeSingle(response.body, responseConverter);
  }

  Future<R> put<T extends JsonSerializable, R>(String uri, T body, R Function(Map<String, dynamic>) responseConverter) async {
    uri = _sanitizeUri(uri);
    final bodyMap = body.toJson();

    final response = await helper.put("$baseUrl/$uri", body: bodyMap, headers: { HttpHeaders.contentTypeHeader: ContentType.json.mimeType });
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeSingle(response.body, responseConverter);
  }

  Future<void> delete(String uri) async {
    uri = _sanitizeUri(uri);
    final response = await helper.delete("$baseUrl/$uri");
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }

  T decodeSingle<T>(String content, T Function(Map<String, dynamic>) parserFactory) => parserFactory(jsonDecode(content));

  List<T> decodeMany<T>(String content, T Function(Map<String, dynamic>) parserFactory) => List<T>.of(jsonDecode(content).map((item) => parserFactory(item)));

  String _sanitizeUri(String uri) {
    if (uri.startsWith('/')) {
      uri = uri.substring(1);
    }

    return uri;
  }
}