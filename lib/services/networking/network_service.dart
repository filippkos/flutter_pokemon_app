import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract interface class NetworkServiceInterface {

  Future<Response> request(String stringUrl);
  Future<Response> uriRequest(Uri uri);
}

class NetworkService implements NetworkServiceInterface {

  @override
  Future<Response> request(String stringUrl) async {
    var url = Uri.parse(stringUrl);

    return await http.get(url);
  }

  @override
  Future<Response> uriRequest(Uri uri) async {
    return await http.get(uri);
  }
}

