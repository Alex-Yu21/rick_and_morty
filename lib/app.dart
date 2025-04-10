import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/data/repositories/dio_settings.dart';
import 'package:rick_and_morty/presentation/blocs/chars_bloc/chars_bloc.dart';
import 'package:rick_and_morty/presentation/providers/bottom_nav_provider.dart';
import 'package:rick_and_morty/presentation/providers/favorites_provider.dart';
import 'package:rick_and_morty/presentation/providers/theme_provider.dart';
import 'package:rick_and_morty/presentation/screens/main_screen.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';
import 'package:rick_and_morty/services/services.dart';

class RickandMorty extends StatelessWidget {
  const RickandMorty({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box<ResultsHiveModel>('favorites');
    final dioSettings = DioSettings();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(HiveFavoritesStorage(favoritesBox)),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<DioSettings>.value(value: dioSettings),
              RepositoryProvider<GetCharsRepo>(
                create: (_) => GetCharsRepo(dio: dioSettings.dio),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<CharsBloc>(
                  create:
                      (context) =>
                          CharsBloc(repo: context.read<GetCharsRepo>())
                            ..add(GetAllChars()),
                ),
              ],
              child: MaterialApp(
                title: 'Rick and Morty',
                debugShowCheckedModeBanner: false,
                theme: context.watch<ThemeProvider>().theme,
                home: const MainScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
