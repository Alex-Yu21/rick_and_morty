import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/main_screen.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Rick and Morty',
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeProvider>().theme,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
