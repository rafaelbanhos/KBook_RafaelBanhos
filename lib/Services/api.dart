// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:kbook_rafaelbanhos/Services/config.dart';

class Api {
  Future get(int index) async {
    http.Response response;
    response = await http.get(
        "${Config.apiUrl}?q=${Config.apiDefaultQuery}&key=${Config.apiKey}&maxResults=${Config.maxResult}&startIndex=$index");
    return response;
  }
}
