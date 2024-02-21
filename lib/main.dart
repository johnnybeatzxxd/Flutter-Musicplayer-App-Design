import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer_app/Theme/theme.dart';

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
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              )),
          title: const Column(
            children: [
              Text(
                "Sarwar Jahan",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Gold Member",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
                color: Color.fromRGBO(142, 142, 142, 1),
              ),
            ),
          ],
        ),
        body:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                     Text(
                      'Listen The\nLatest Musics',
                      style: TextStyle(
                          fontSize: 26,
                          fontFamily: "Nunito",
                          fontWeight:
                              FontWeight.w400 // Adjust text color for contrast
                          ),
                    ),
                  
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                      width: 180,
                      height: 48,
                      child: TextField(
                        decoration: InputDecoration(
                            prefix: Icon(Icons.search, size: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            hintText: "    Search Music",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)))),
                      ))
                ],
              ),
              SizedBox(height: 50,),
              Text("Recently Played",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Container(
                    width: 101.0,
                    height: 81.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                    
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      
                      width: 101.0,
                      height: 81.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: 101.0,
                      height: 81.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      
                      width: 101.0,
                      height: 81.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                      
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
