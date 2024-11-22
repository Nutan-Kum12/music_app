import 'package:flutter/material.dart';

ThemeData spotifyDarkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.green, // Spotify Green
    secondary: Colors.black, // Black background
    surface: Color(0xff121212), // Spotify's dark surface color
    tertiary: Colors.greenAccent, // Slightly brighter green for accents
    inversePrimary: Colors.grey.shade400, // Inverse primary for subtle dark elements
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Default body text color
    bodyMedium: TextStyle(color: Colors.white70), // Medium-size body text
    bodySmall: TextStyle(color: Colors.grey), // Subtle, smaller text
  ),
  scaffoldBackgroundColor: Color(0xff121212), // Spotify's background
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff121212), // Spotify Dark AppBar
    titleTextStyle: TextStyle(
      color: Colors.white, // White title
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.green, // Green buttons
    textTheme: ButtonTextTheme.primary, // White text on buttons
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Spotify Green for ElevatedButton
      foregroundColor: Colors.white, // White text
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.green), // Spotify Green border
      foregroundColor: Colors.green, // Green text
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white, // White icons
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.white), // White labels
    hintStyle: const TextStyle(color: Colors.white70), // Lighter white for hints
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green), // Green focus border
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade700), // Grey border for enabled
    ),
  ),
);
