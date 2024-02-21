import "package:flutter/material.dart";

ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black, // Background color
  onPrimary: Colors.black, // Text color
  //primaryVariant: Colors.grey[300], // Lighter grey for variations
  secondary: Colors.grey.shade200, // Optional accent color
  onSecondary: Colors.black, // Text color on accent
  //secondaryVariant: Colors.blue[700], // Darker accent for variations
  background: Color.fromARGB(255, 50, 37, 37), // Slightly lighter background for surfaces
  onBackground: Colors.black, // Text color on surfaces
  surface: Colors.grey, // Lighter surface color for cards, etc.
  onSurface: Colors.black, // Text color on surfaces
  error: Colors.red, // Error color
  onError: Colors.white, // Text color on error
);

ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromRGBO(10, 7, 30, 1), // Background color
  onPrimary: const Color.fromARGB(255, 117, 116, 116), // Text color
  //primaryVariant: Colors.grey.shade800, // Slightly lighter grey for variations
  secondary: Color.fromRGBO(53, 53, 54, 1),//Color.fromRGBO(44, 42, 50, 1), // Optional accent color
  onSecondary: Colors.white, // Text color on accent
  //secondaryVariant: Colors.blue.shade700, // Darker accent for variations
  background: Color.fromRGBO(10, 7, 30, 1),
  onBackground: Color.fromARGB(255, 188, 186, 186), // Lighter text color on surfaces
  surface: Color.fromRGBO(204, 204, 204, 1), // Same as background for consistency
  onSurface: Colors.grey.shade200, // Text color on surfaces
  error: Colors.red, // Error color
  onError: Colors.white,


   // Text color on error
);

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    

  );
}

ThemeData darkTheme() {
  return ThemeData(
      //primarySwatch: null,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.primary)
          );

}
