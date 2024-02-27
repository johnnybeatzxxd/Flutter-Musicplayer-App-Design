import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services package
import 'index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([ // Lock orientation to portrait
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme(),
      title: 'Musica',
      initialRoute: '/home',
      routes: {
        '/home': (context) => Homepage(),
        '/music': (context) => PlaygroundPage(),
        '/favourite': (context) => FavoritePage(),
        // Add more routes for your pages here
      },
    );
  }
}

