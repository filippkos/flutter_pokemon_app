import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkService {

  Future<Response> request(String stringUrl) async {
    var url = Uri.parse(stringUrl);

    return await http.get(url);
  }

  Future<Response> uriRequest(Uri uri) async {
    return await http.get(uri);
  }
}

