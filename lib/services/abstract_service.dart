
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mixtape/models/json_serializable.dart';
import 'package:mixtape/utilities/json_utilities.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'file_upload_http_client.dart';

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
  Future<List<T>> getMany<T>(String uri, T Function(Map<String, dynamic>) parserFactory, { Map<String, dynamic>? paramMap }) async {
    uri = _sanitizeUri(uri);
    uri = _addParamsToUri(uri, paramMap);

    final response = await helper.get("$baseUrl/$uri");
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }
    print(response.body);

    return decodeMany(response.body, parserFactory);
  }

  Future<R> post<T extends JsonSerializable, R>(String uri, T body, R Function(Map<String, dynamic>) responseConverter) async {
    uri = _sanitizeUri(uri);
    final bodyMap = jsonEncode(body.toJson());

    return postString(uri, bodyMap, responseConverter);
  }

  Future<R> postWithoutBody<R>(String uri, R Function(Map<String, dynamic>) responseConverter) async {
    uri = _sanitizeUri(uri);
    print(uri);
    final bodyMap = jsonEncode(null);
    // final response = await helper.post("$baseUrl/$uri", body: jsonEncode(null), headers: { HttpHeaders.contentTypeHeader: ContentType.json.mimeType });
    // if (response.statusCode != 200) {
    //   print("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    //   return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    // }
    // return decodeSingle(response.body, responseConverter);
    return postString(uri, bodyMap, responseConverter);
  }

  Future<R> postString<R>(String uri, String body, DeserializerFactory<R> responseConverter) async {
    print("$baseUrl/$uri");
    final response = await helper.post("$baseUrl/$uri", body: body, headers: { HttpHeaders.contentTypeHeader: ContentType.json.mimeType });
    print(response.body);
    if (response.statusCode != 200) {
      print("Request error: ${response.statusCode} - ${response.reasonPhrase}");
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeSingle(response.body, responseConverter);
  }

  Future<R> put<T extends JsonSerializable?, R>(String uri, T? body, R Function(Map<String, dynamic>) responseConverter) async {
    uri = _sanitizeUri(uri);

    String bodyMap = '';
    if (body != null) {
      bodyMap = jsonEncode((body as JsonSerializable).toJson());
    }
    return putString(uri, bodyMap, responseConverter);
  }

  Future<R> putString<R>(String uri, String body, DeserializerFactory<R> responseConverter) async {
    final response = await helper.put("$baseUrl/$uri", body: body, headers: { HttpHeaders.contentTypeHeader: ContentType.json.mimeType });
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

  Future<R> putXFile<R>(String uri, XFile file, String fileId, R Function(Map<String, dynamic>) parserFactory) async {
    final fileUploadClient = XFileUploadHttpClient(fileId, null);
    uri = _sanitizeUri(uri);

    final response = await helper.put("$baseUrl/$uri", body: file, httpClient: fileUploadClient);
    if (response.statusCode != 200) {
      return Future.error("Request error: ${response.statusCode} - ${response.reasonPhrase}");
    }

    return decodeSingle(response.body, parserFactory);
  }

  T decodeSingle<T>(String content, T Function(Map<String, dynamic>) parserFactory) => parserFactory(jsonDecode(content));

  List<T> decodeMany<T>(String content, T Function(Map<String, dynamic>) parserFactory) {
    Iterable objectIterable = jsonDecode(content);
    return jsonDecodeList(objectIterable, parserFactory);
  }

  String _sanitizeUri(String uri) {
    if (uri.startsWith('/')) {
      uri = uri.substring(1);
    }

    return uri;
  }

  String _addParamsToUri(String uri, Map<String, dynamic>? paramMap) {
    if (paramMap != null) {
      Map<String, String> paramStrings = paramMap.map((key, value) => MapEntry(key, value.toString()));
      uri = Uri(path: uri, queryParameters: paramStrings).toString();
    }

    return uri;
  }
}
