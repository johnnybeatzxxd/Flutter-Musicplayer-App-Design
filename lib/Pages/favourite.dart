import "package:flutter/material.dart";

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    child: Image.asset("images/RectangleProfile.png", width: 91, height: 100),
                  ),
                ),
                SizedBox(width: 20), 
                Expanded( 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
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
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7), // Lighter white color for the email
                        ),
                      ),
                      Text(
                        "Gold Member",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      Text(
                        "Love Music and I am not an Musician.",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7), // Lighter white color for the bio
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
