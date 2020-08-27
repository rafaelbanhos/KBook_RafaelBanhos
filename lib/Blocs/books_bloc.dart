// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:kbook_rafaelbanhos/Models/book_model.dart';
import 'package:kbook_rafaelbanhos/Services/api.dart';

class BooksBloc extends BlocBase {
  List<BookModel> books = [];

  final _booksAvailable$ = StreamController<List<BookModel>>();

  Stream<List<BookModel>> get booksAvailableOut => _booksAvailable$.stream;

  Future getBooks(int index) async {
    var result = await Api().get(index);
    _customDecode(result);
  }

  _customDecode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      var items = decoded["items"].map<BookModel>((map) {
        var bookModel = BookModel.fromJson(map);
        var existAsBook = books.where((book) => book.id == bookModel.id);
        //avoiding duplicate books and without volume info, description and no imagens.
        if (existAsBook.length == 0 &&
            bookModel.hasVolumeInfo() &&
            bookModel.volumeModel.hasDescription() &&
            bookModel.volumeModel.hasImageLinks()) return bookModel;
      }).toList();

      books += items.where((element) => element != null).toList();
      _booksAvailable$.sink.add(books);
    } else {
      throw Exception("Failed to load books");
    }
  }

  @override
  void dispose() {
    _booksAvailable$.close();
    super.dispose();
  }
}
