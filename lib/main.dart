import 'dart:io';

import 'package:flutter/material.dart';
import 'index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyScaffold());
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: darkTheme(),
        debugShowCheckedModeBanner: false, // Ensure MaterialApp is present
        theme: darkTheme(),
        home: Homepage());
  }
}
