import "package:flutter/material.dart";
import "package:musicplayer_app/Providers/playgroundProvider.dart";
import "package:musicplayer_app/components/myicons.dart";
import "package:musicplayer_app/index.dart";
import "package:provider/provider.dart";

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
                    activeColor: const Color.fromRGBO(97, 86, 226, 1),
                    value: Provider.of<playGroundProvider>(context,listen:true).slider,
                    onChanged: (value) => Provider.of<playGroundProvider>(context,listen:false).setSlider(value),
                    label: Provider.of<playGroundProvider>(context,listen:true).slider.round().toString(),
                    min: 0,
                    max: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: Icon(Icons.shuffle,), onPressed: (){},),
                      IconButton(icon: Icon(Icons.skip_previous_outlined, size: 40), onPressed: (){},),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
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
                      IconButton(icon: Icon(Icons.skip_next_outlined, size: 40), onPressed: (){},),
                      IconButton(icon: Icon(Icons.repeat), onPressed: (){},),
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
