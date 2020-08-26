import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:kbook_rafaelbanhos/Blocs/books_bloc.dart';
import 'package:kbook_rafaelbanhos/Screens/book_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _search;
  int _offset = 0;

  var booksBloc = BlocProvider.getBloc<BooksBloc>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 179, 190, 1),
        title: Text('Kentra Challenge'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: booksBloc.getBooks(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 5.0,
                ),
              );
            default:
              if (snapshot.hasError)
                return Container();
              else
                return _createBooksTable(context, snapshot);
          }
        },
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createBooksTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: _getCount(snapshot.data["items"]),
        itemBuilder: (context, index) {
          if (index < snapshot.data["items"].length)
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["items"][index]["volumeInfo"]["imageLinks"]
                    ["smallThumbnail"],
                height: 300.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookDetailsScreen(snapshot.data["items"][index])));
              },
            );
          else
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 70.0,
                    ),
                    Text(
                      "Carregar mais...",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    _offset += 9;
                  });
                },
              ),
            );
        });
  }

  Widget _buildFloating() {
    return SpeedDial(
      child: Icon(Icons.sort),
      backgroundColor: Color.fromRGBO(25, 179, 190, 1),
      overlayOpacity: 0.4,
      overlayColor: Colors.black,
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.library_books,
              color: Colors.greenAccent,
            ),
            backgroundColor: Colors.white,
            label: "All Books",
            labelStyle: TextStyle(fontSize: 14),
            onTap: () {}),
        SpeedDialChild(
            child: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
            backgroundColor: Colors.white,
            label: "Only Favorites",
            labelStyle: TextStyle(fontSize: 14),
            onTap: () {}),
      ],
    );
  }
}
