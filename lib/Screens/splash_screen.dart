import 'package:flutter/material.dart';
import 'package:kbook_rafaelbanhos/Screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 179, 190, 1),
      child: Center(
        child: Container(
          height: 80,
          child: Column(
            children: [
              Text(
                'Kentra',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    decoration: TextDecoration.none),
              ),
              Text(
                'Challenge',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
