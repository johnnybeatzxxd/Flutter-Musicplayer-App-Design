import "package:flutter/material.dart";
import "package:musicplayer_app/Providers/mainProvider.dart";
import "package:musicplayer_app/index.dart";
import "package:provider/provider.dart";
import "package:permission_handler/permission_handler.dart";

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
                
                  Provider.of<MainProvider>(context, listen: false)
                      .currentPage(index);
              
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: Provider.of<MainProvider>(context, listen: true)
                  .currentPageIndex,
              selectedLabelStyle:
                  const TextStyle(color: Color.fromRGBO(97, 86, 226, 1)),
              items: [
                BottomNavigationBarItem(
                    activeIcon: MyCustomIcon('assets/icons/home.svg',
                        color: Color.fromRGBO(97, 86, 226, 1)),
                    icon: MyCustomIcon('assets/icons/home.svg'),
                    label: "home"),
                BottomNavigationBarItem(
                    activeIcon: MyCustomIcon(
                      "assets/icons/music.svg",
                      color: Color.fromRGBO(97, 86, 226, 1),
                    ),
                    icon: MyCustomIcon("assets/icons/music.svg"),
                    label: "music"),
                BottomNavigationBarItem(
                    activeIcon: MyCustomIcon(
                      "assets/icons/heart.svg",
                      color: Color.fromRGBO(97, 86, 226, 1),
                    ),
                    icon: MyCustomIcon("assets/icons/heart.svg"),
                    label: "heart"),
                BottomNavigationBarItem(
                    activeIcon: MyCustomIcon(
                      "assets/icons/map.svg",
                      color: Color.fromRGBO(97, 86, 226, 1),
                    ),
                    icon: MyCustomIcon("assets/icons/map.svg"),
                    label: "map"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
