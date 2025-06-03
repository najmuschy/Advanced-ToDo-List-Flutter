import 'package:flutter/material.dart' ;
import 'Home.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        appBarTheme: AppBarTheme(
          color: Colors.amber,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Color.fromRGBO(9, 1, 25, 0.8),
      ),
      home: Home(),
    );
  }
}
