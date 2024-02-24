import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer_app/Theme/theme.dart';
import 'package:musicplayer_app/components/myicons.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Container(
              height: 40,
              width: 40,
              child: CircleAvatar(
                child: Image.asset("images/profile.png"),
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
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
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
                                fontWeight: FontWeight
                                    .w400 // Adjust text color for contrast
                                ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                                width: 180,
                                height: 48,
                                child: TextField(
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade700),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(60))),
                                      hintText: "       Search Music",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white70),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(60)))),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Recently Played",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Nunito",
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 101.0,
                                      height: 81.0,
                                      child:
                                          Image.asset("images/Rectangle18.png"),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Text("The triangle")
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 101.0,
                                      height: 81.0,
                                      child:
                                          Image.asset("images/Rectangle17.png"),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Text("Dune Of Visa")
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 101.0,
                                      height: 81.0,
                                      child:
                                          Image.asset("images/Rectangle16.png"),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Text("Riskitall")
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 101.0,
                                          height: 81.0,
                                          child: Image.asset(
                                              "images/Rectangle18.png"),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("hello")
                                ],
                              ),
                            ]),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            "Recommend for you",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 10, 12),
                                  child: Container(
                                    width: 88.0,
                                    height: 88.0,
                                    child: Image.asset("images/rectangle7.png"),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "Take care of you",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "Admina Thembi",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "114k / steams",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 10, 12),
                                  child: Container(
                                    width: 88.0,
                                    height: 88.0,
                                    child: Image.asset("images/Rectangle8.png"),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "The stranger inside you",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "Jeane Lebras",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "60.5k / steams",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 10, 12),
                                  child: Container(
                                    width: 88.0,
                                    height: 88.0,
                                    child: Image.asset("images/Rectangle9.png"),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "Edwall of beauty mind ",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "Jacob Givson",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "44.3k / steams",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: kBottomNavigationBarHeight * 1.5,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(124, 158, 158, 158),
                        blurRadius: 6.0,
                        offset: Offset(0, -1.0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50), bottom: Radius.zero),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      selectedIconTheme:
                          IconThemeData(color: Color.fromRGBO(97, 86, 226, 1)),
                      selectedLabelStyle:
                          TextStyle(color: Color.fromRGBO(97, 86, 226, 1)),
                      items: [
                        BottomNavigationBarItem(
                            icon: MyCustomIcon('assets/icons/home.png'),
                            label: "home"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/music.png"),
                            label: "music"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/heart.png"),
                            label: "heart"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/map.png"),
                            label: "map"),
                       
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
