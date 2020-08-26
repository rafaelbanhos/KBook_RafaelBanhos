// Dart imports:
import 'dart:async';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final String favorite = 'my_favourite';

  Completer<SharedPreferences> instance = Completer<SharedPreferences>();
  SharedPreferences _share;

  LocalStorageService() {
    _initLocalStorage();
  }

  _initLocalStorage() async {
    _share = await SharedPreferences.getInstance();
    if (!instance.isCompleted) instance.complete(_share);
  }

  Future removeAll() async {
    SharedPreferences share = await instance.future;
    return share.clear();
  }
}
