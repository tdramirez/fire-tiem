import 'package:flutter/material.dart';
import 'package:fire_team/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.deepOrange,
      title: 'Fire Team',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context)=> HomePage()
      },
    );

  }
}

