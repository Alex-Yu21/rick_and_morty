import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/main_screen.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';
import 'package:rick_and_morty/providers/bottom_nav_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const RickAndMortyApp(),
    ),
  );
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      home: const MainScreen(),
    );
  }
}
