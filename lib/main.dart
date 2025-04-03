import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/main_screen.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF42B4CA),
          secondary: Color(0xFFD5E9ED),
          surface: Colors.white,
          onSurface: Color(0xFF414A4C),
          error: Color(0xFF414A4C),
          tertiary: Color(0xFFB5C4C7),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(foregroundColor: const Color(0xFF42B4CA)),
        ),

        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF414A4C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF97C3E9),
          secondary: Color(0xFF778899),
          surface: Color(0xFF414A4C),
          onSurface: Colors.white,
          error: Color(0xFF414A4C),
          tertiary: Color(0xFFB5C4C7),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(foregroundColor: const Color(0xFF97C3E9)),
        ),

        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}
