import 'package:flutter/material.dart';
import 'location_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(4, 18, 41, 1),
          accentColor: Color.fromRGBO(247, 182, 12, 1),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: LocationService(),
    );
  }
}

