import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:musicplayer_app/Pages/playground.dart';
import 'package:musicplayer_app/Theme/theme.dart';
import 'package:musicplayer_app/components/myicons.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
                color: const Color.fromRGBO(142, 142, 142, 1),
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
                          const Text(
                            'Listen The\nLatest Musics',
                            style: TextStyle(
                                fontSize: 26,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight
                                    .w400 // Adjust text color for contrast
                                ),
                          ),
                          const SizedBox(
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(60))),
                                      hintText: "       Search Music",
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white70),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(60)))),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
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
                                  const Text("The triangle")
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
                                  const Text("Dune Of Visa")
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
                                  const Text("Riskitall")
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
                                  const Text("hello")
                                ],
                              ),
                            ]),
                      ),
                      const SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
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
                                const Column(
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
                                const Column(
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
                                const Column(
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
                      ),
                    SizedBox(height: kBottomNavigationBarHeight * 1.4,)
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
                  decoration: const BoxDecoration(
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
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50), bottom: Radius.zero),
                    child: BottomNavigationBar(
                      onTap: (value) =>
                        (Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Playground(),
                    ))),
                      type: BottomNavigationBarType.fixed,
                      selectedIconTheme:
                          const IconThemeData(color: Color.fromRGBO(97, 86, 226, 1)),
                      selectedLabelStyle:
                          const TextStyle(color: Color.fromRGBO(97, 86, 226, 1)),
                      items: [
                        BottomNavigationBarItem(
                            icon: MyCustomIcon('assets/icons/home.svg',color: Colors.blue),
                            label: "home"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/music.svg"),
                            label: "music"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/heart.svg"),
                            label: "heart"),
                        BottomNavigationBarItem(
                            icon: MyCustomIcon("assets/icons/map.svg"),
                            label: "map"),
                       
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}