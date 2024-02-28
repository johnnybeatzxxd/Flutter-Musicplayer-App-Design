import "package:flutter/material.dart";
import "package:musicplayer_app/index.dart";

class ButtomNavBar extends StatelessWidget {
  int currentIndex = 0;
  ButtomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: kBottomNavigationBarHeight * 1.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
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
              onTap: (int index) {
                                switch (index) {
                  case 0:
                    this.currentIndex = 0;
                    Navigator.pushNamed(context, '/home');
                                        break;
                  case 1:
                    this.currentIndex = 1;
                    Navigator.pushNamed(context, '/music');
                                        break;
                  case 2:
                    this.currentIndex = 2;
                    Navigator.pushNamed(context, '/favourite');
                                        break;
                  case 3:
                    currentIndex = 3;
                    Navigator.pushNamed(context, '/home');
                                        break;
                }
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: this.currentIndex,
              selectedIconTheme:
                  const IconThemeData(color: Color.fromRGBO(97, 86, 226, 1)),
              selectedLabelStyle:
                  const TextStyle(color: Color.fromRGBO(97, 86, 226, 1)),
              items: [
                BottomNavigationBarItem(
                    icon: MyCustomIcon('assets/icons/home.svg',),
                    label: "home"),
                BottomNavigationBarItem(
                    icon: MyCustomIcon("assets/icons/music.svg"),
                    label: "music"),
                BottomNavigationBarItem(
                    icon: MyCustomIcon("assets/icons/heart.svg"),
                    label: "heart"),
                BottomNavigationBarItem(
                    icon: MyCustomIcon("assets/icons/map.svg"), label: "map"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
