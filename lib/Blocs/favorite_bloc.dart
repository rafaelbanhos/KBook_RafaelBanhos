// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Models/book_model.dart';

class FavoriteBloc extends BlocBase {
  Map<String, BookModel> _favorites = {};

  final _favController = BehaviorSubject<Map<String, BookModel>>();

  Stream<Map<String, BookModel>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, BookModel.fromJson(v));
        }).cast<String, BookModel>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleAsFavorite(BookModel book) {
    if (_favorites.containsKey(book.id))
      _favorites.remove(book.id);
    else
      _favorites[book.id] = book;
    _favController.sink.add(_favorites);
    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
