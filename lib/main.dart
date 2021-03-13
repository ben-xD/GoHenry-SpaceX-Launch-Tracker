import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_time/ui/screen/upcoming_launches.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(172, 85, 138, 1),
          accentColor: Color.fromRGBO(83, 201, 193, 1),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72),
            headline4: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 20, color: Colors.white),
            bodyText2: TextStyle(fontSize: 20, color: Colors.grey, fontStyle: FontStyle.italic),
          )
        ),
        home: UpcomingLaunches()
    );
  }
}