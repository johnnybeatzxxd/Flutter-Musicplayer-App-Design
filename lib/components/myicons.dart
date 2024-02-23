import "package:flutter/material.dart";

class MyCustomIcon extends Icon {
  final String imagePath;

  MyCustomIcon(this.imagePath) : super(Icons.ac_unit);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath);
  }
}
