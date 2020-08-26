// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:transparent_image/transparent_image.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Blocs/books_bloc.dart';
import 'package:kbook_rafaelbanhos/Models/book_model.dart';
import 'package:kbook_rafaelbanhos/Screens/book_details_screen.dart';
import 'package:kbook_rafaelbanhos/Screens/favorite_screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int pageCount = 0;
  ScrollController _scrollController;
  var booksBloc = BlocProvider.getBloc<BooksBloc>();

  @override
  void initState() {
    super.initState();
    requestBooksFromGoogleApi(1);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 179, 190, 1),
          title: Text('Kentra Challenge'),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoritesScreen()));
                },
                child: Icon(Icons.list))
          ],
        ),
        body: StreamBuilder<List<BookModel>>(
            stream: booksBloc.booksAvailableOut,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: Container());
                default:
              }

              return GridView.count(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                physics: const AlwaysScrollableScrollPhysics(),
                children: snapshot.data.map((book) {
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
            }));
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;

        if (isLoading) {
          pageCount = pageCount + 1;
          requestBooksFromGoogleApi(pageCount);
          print("RUNNING LOAD MORE $pageCount");
        }
      });
    }
  }

  void requestBooksFromGoogleApi(var pageCount) {
    booksBloc.getBooks(pageCount);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
