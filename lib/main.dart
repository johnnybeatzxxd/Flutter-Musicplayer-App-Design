import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setPreferredOrientations([ 
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
        
      },
    );
  }
}

