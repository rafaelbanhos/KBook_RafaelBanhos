import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        actions: [
          GestureDetector(onTap: () {}, child: Icon(Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.grey,
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
            Text('Author: ' + _bookDetails["volumeInfo"]["authors"].toString()),
            SizedBox(
              height: 6,
            ),
            Text('Description: ' + _bookDetails["volumeInfo"]["description"]),
            SizedBox(
              height: 6,
            ),
            _bookDetails["saleInfo"]["buyLink"] != null
                ? RaisedButton(
                    child: Text('BUY'),
                    onPressed: () async {
                      print(_bookDetails["saleInfo"]["buyLink"]);

                      String url =
                          _bookDetails["saleInfo"]["buyLink"].toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  )
                : RaisedButton(
                    child: Text('Not possible'),
                    onPressed: () async {},
                  )
          ],
        ),
      ),
    );
  }
}
