import 'package:flutter/material.dart';
import 'package:pensieve/Routes/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Dump',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Brain Dump'),
      debugShowCheckedModeBanner: false,
    );
  }
}
