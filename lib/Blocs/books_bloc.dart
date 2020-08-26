import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;

class BooksBloc extends BlocBase {

  Future<Map> getBooks() async {
    http.Response response;

    response = await http.get(
        "https://www.googleapis.com/books/v1/volumes?q=flutter&maxResults=20&startIndex=0");

    return json.decode(response.body);
  }
}
