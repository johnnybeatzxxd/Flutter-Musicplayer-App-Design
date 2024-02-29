import "package:flutter/material.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:musicplayer_app/index.dart";

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Song name")),
        ),
        body: Stack(alignment: AlignmentDirectional.topCenter, children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 319,
                          width: 304,
                          child: Image.asset("images/Rectangle19.png"),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(97, 86, 226, 1),
                              borderRadius: BorderRadius.circular(38)))),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Song name",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Text(
                    "Artist name",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Slider(
                    value: 0,
                    onChanged: (value) => null,
                    min: 0,
                    max: 3.15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shuffle),
                      SizedBox(
                        width: 50,
                      ),
                      Icon(Icons.skip_previous_outlined, size: 35),
                      Container(
                        width: 130,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                              child: AnimatedIcon(
                                icon: AnimatedIcons.pause_play,
                                progress: kAlwaysCompleteAnimation,
                                size: 50,
                                color: Colors.white,
                              ), //Icon(Icons.pause,size: 50,color: Colors.white,),
                              backgroundColor: Color.fromRGBO(97, 86, 226, 1),
                              radius: 40),
                        ),
                      ),
                      Icon(
                        Icons.skip_next_outlined,
                        size: 35,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Icon(Icons.repeat),
                    ],
                  ),
                SizedBox(height: kBottomNavigationBarHeight * 1.5,)
                ],
              ),
            ),
          ),
         ButtomNavBar()
        ]));
  }
}
