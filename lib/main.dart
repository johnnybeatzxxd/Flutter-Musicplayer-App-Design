import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'dart:io';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('Musics');
  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => playGroundProvider(),
        ),
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  List tabs = [
    Homepage(),
    MusicsPage(),
    FavoritePage(),
    Homepage(),
    PlaygroundPage()
  ];
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme(),
      theme: lightTheme(),
      title: 'Musica',
      home: tabs[
          Provider.of<MainProvider>(context, listen: true).currentPageIndex],
    );
  }
}
