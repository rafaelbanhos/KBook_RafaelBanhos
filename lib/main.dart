import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbook_rafaelbanhos/Screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kentra Challenge',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
