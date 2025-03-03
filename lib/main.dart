import 'package:flutter/material.dart';
import 'package:band_names/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material app',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomePage()
        },
      );
  }
}
