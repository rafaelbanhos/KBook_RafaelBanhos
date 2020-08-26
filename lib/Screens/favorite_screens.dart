// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:transparent_image/transparent_image.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Blocs/favorite_bloc.dart';
import 'package:kbook_rafaelbanhos/Models/book_model.dart';
import 'package:kbook_rafaelbanhos/Screens/book_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 179, 190, 1),
        title: Text("My Favorites"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<Map<String, BookModel>>(
            stream: favoriteBloc.outFav,
            initialData: {},
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                physics: const AlwaysScrollableScrollPhysics(),
                children: snapshot.data.values.map((book) {
                  return GestureDetector(
                    child: book.volumeModel.hasImageLinks()
                        ? FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: book.volumeModel.imageLinks.smallThumbnail)
                        : Container(
                            color: Colors.red,
                          ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetailsScreen(book)));
                    },
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
