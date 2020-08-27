// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Blocs/books_bloc.dart';
import 'package:kbook_rafaelbanhos/Blocs/favorite_bloc.dart';
import 'package:kbook_rafaelbanhos/Models/book_model.dart';

// ignore: must_be_immutable
class BookDetailsScreen extends StatelessWidget {
  final BookModel _bookDetails;
  var favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

  BookDetailsScreen(this._bookDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 179, 190, 1),
        title: Text(_bookDetails.volumeModel.title),
        centerTitle: true,
        actions: [
          StreamBuilder<Map<String, BookModel>>(
              stream: favoriteBloc.outFav,
              initialData: {},
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return GestureDetector(
                      onTap: () async {
                        favoriteBloc.toggleAsFavorite(_bookDetails);
                      },
                      child: Icon(Icons.favorite_border));
                }

                var currentBookExistAsFavorite =
                    snapshot.data.keys.contains(_bookDetails.id);

                return GestureDetector(
                    onTap: () async {
                      favoriteBloc.toggleAsFavorite(_bookDetails);
                    },
                    child: Icon(currentBookExistAsFavorite
                        ? Icons.favorite
                        : Icons.favorite_border));
              }),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: _bookDetails.volumeModel.hasImageLinks()
                    ? Image.network(
                        _bookDetails.volumeModel.imageLinks.thumbnail,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        color: Colors.red,
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Text(
                _bookDetails.volumeModel.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text('Author: ' + _bookDetails.volumeModel.authors.toString()),
              SizedBox(
                height: 6,
              ),
              Text('Description: ' + _bookDetails.volumeModel.description),
              SizedBox(
                height: 6,
              ),
              _bookDetails.saleModel.hasBuyLink()
                  ? ButtonTheme(
                      minWidth: 135,
                      height: 50,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(14.0)),
                        color: Color.fromRGBO(25, 179, 190, 1),
                        child: Text(
                          'BUY',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          String url =
                              _bookDetails.saleModel.buyLink.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    )
                  : ButtonTheme(
                      minWidth: 135,
                      height: 50,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(14.0)),
                        child: Text('Unavailable'),
                      ),
                    ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
