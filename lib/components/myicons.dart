import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCustomIcon extends StatelessWidget {
  final String imagePath;
  final Color color;
  final double width; 
  final double height; 

  const MyCustomIcon(this.imagePath, {super.key, this.color = Colors.grey,this.width = 20,this.height = 20}); // Default color

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      // ignore: deprecated_member_use
      color: color,
      width: width,
      height: height,
       // Colorize using provided color
    );
  }
}
