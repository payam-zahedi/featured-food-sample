import 'package:flutter/material.dart';
import 'view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Featured Food",
      home: FoodHome(),
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: "slabo"),
    );
  }
}
