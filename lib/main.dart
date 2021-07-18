import 'package:flutter/material.dart';
import 'View/RecipeSearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: RecipeSearch(),
    );
  }
}
