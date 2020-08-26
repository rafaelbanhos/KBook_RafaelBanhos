import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final Map _bookDetails;

  BookDetailsScreen(this._bookDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 179, 190, 1),
        title: Text(_bookDetails["volumeInfo"]["title"]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.grey,
              elevation: 2,
              child: Column(
                children: [
                  Image.network(
                      _bookDetails["volumeInfo"]["imageLinks"]["thumbnail"])
                ],
              ),
            ),
            Text(_bookDetails["volumeInfo"]["title"]),
            SizedBox(
              height: 6,
            ),
            Text('Description: ' + _bookDetails["volumeInfo"]["subtitle"]),
            SizedBox(
              height: 6,
            ),
            Text('Author: ' + _bookDetails["volumeInfo"]["authors"].toString()),
            SizedBox(
              height: 6,
            ),

          ],
        ),
      ),
    );
  }
}
