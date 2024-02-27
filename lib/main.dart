import 'package:flutter/material.dart';
import 'index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme(),
      title: 'Musica',
      // Define initial route
      initialRoute: '/home',
      // Define named routes
      routes: {
        '/home': (context) => Homepage(), // Home route
        '/music': (context) => PlaygroundPage(), // Example route
        '/favourite': (context) => FavoritePage(), // Another example route
        // Add more routes for your pages here
      },
    );
  }
}

