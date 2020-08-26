// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Blocs/books_bloc.dart';
import 'package:kbook_rafaelbanhos/Blocs/favorite_bloc.dart';
import 'package:kbook_rafaelbanhos/Screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => BooksBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'Kentra Challenge',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
