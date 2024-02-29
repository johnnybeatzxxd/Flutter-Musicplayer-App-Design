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
                      IconButton(icon: Icon(Icons.shuffle),onPressed: (){},padding: EdgeInsets.symmetric(horizontal: 28),),
                      IconButton(icon:Icon(Icons.skip_previous_outlined, size: 35),onPressed: (){},padding: EdgeInsets.zero),
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
                          child: PlayPause(),
                        ),
                      ),
                      IconButton(
                        icon:Icon(Icons.skip_next_outlined,
                        size: 35,),onPressed: (){},padding: EdgeInsets.zero,),
                      IconButton(icon:Icon(Icons.repeat),onPressed: (){},padding: EdgeInsets.symmetric(horizontal: 28),),
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
