import 'package:flutter/material.dart';
import 'package:musicplayer_app/Pages/favourite.dart';
import 'package:musicplayer_app/Pages/playground.dart';
import 'index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme(),
        title: 'Musica',
        home: FavoritePage());
  }
}

