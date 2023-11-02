
import 'dart:convert';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class XFileUploadHttpClient extends BaseClient {

  Client client;
  String fieldName;

  XFileUploadHttpClient(this.fieldName, Client? wrappedClient)
  : client = wrappedClient ?? Client();


  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {

    // custom behavior
    if (body != null && body is XFile) {

      XFile file = body;

      final request = MultipartRequest('PUT', url);
      return MultipartFile.fromPath(fieldName, file.path)
          .then((value) {
            request.files.add(value);
            request.headers.addAll(headers ?? {});
            return send(request)
              .then((value) => Response.fromStream(value));
          });
    } else {
      return client.put(url, headers: headers, body: body, encoding: encoding);
    }
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return client.send(request);
  }
}
