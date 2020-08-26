import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 179, 190, 1),
        title: Text('Kentra Challenge'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
