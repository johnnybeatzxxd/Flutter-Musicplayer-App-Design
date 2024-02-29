import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer_app/Providers/mainProvider.dart';
import 'package:musicplayer_app/Providers/playgroundProvider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider(),),
        ChangeNotifierProvider(create: (_) => playGroundProvider(),),
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  List tabs = [Homepage(), const PlaygroundPage(), const FavoritePage(),Homepage()];
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme(),
      title: 'Musica',
      
      home: tabs[Provider.of<MainProvider>(context,listen: true).currentPageIndex],
    );
  }
}
