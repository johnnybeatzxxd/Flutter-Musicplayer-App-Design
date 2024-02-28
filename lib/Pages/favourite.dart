import "package:flutter/material.dart";
import "package:musicplayer_app/index.dart";

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        child: Image.asset("images/RectangleProfile.png",
                            width: 91, height: 100),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            "Sarwar Jahan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500, // Make the name bold
                            ),
                          ),
                          Text(
                            "sarwarmusic@gmail.com",
                          ),
                          Text(
                            "Gold Member",
                           
                          ),
                          Text(
                            "Love Music and I am not an Musician.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
               const Text(
                  "Favourite Ablum",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SingleChildScrollView(
                    controller: ScrollController(initialScrollOffset: 0.0),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("images/Rectangle24.png",
                                    width: 106, height: 111),
                              ),
                            ),
                            const Text(
                              "Album 1",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("images/Rectangle23.png",
                                    width: 106, height: 111),
                              ),
                            ),
                            const Text(
                              "Album 2",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("images/Rectangle22.png",
                                    width: 106, height: 111),
                              ),
                            ),
                            const Text(
                              "Album 3",
                            ),
                          ],
                        ),
                      ],
                    )), // Favorite album section
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Favourite Music",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 4,
                    padding: EdgeInsets.zero,
                    children: List.generate(9, (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                  "images/Rectangle${30 - index}.png",
                                  width: 106,
                                  height: 111),
                            ),
                          ),
                        ],
                      );
                    })
                      ..add(const SizedBox(
                        height: kBottomNavigationBarHeight * 1.0,
                      )),
                  ),
                ),
              ],
            ),
          ), //end of the page
          const ButtomNavBar()
        ]));
  }
}
