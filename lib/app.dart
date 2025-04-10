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
import 'package:rick_and_morty/services/api_client.dart';
import 'package:rick_and_morty/services/dio_api_client.dart';
import 'package:rick_and_morty/services/character_cache.dart';
import 'package:rick_and_morty/services/hive_character_cache.dart';
import 'package:rick_and_morty/services/services.dart';

class RickandMorty extends StatelessWidget {
  const RickandMorty({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box<ResultsHiveModel>('favorites');
    final characterBox = Hive.box<ResultsHiveModel>('cached_chars');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(HiveFavoritesStorage(favoritesBox)),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DioSettings>(create: (_) => DioSettings()),
          RepositoryProvider<ApiClient>(
            create: (context) => DioApiClient(context.read<DioSettings>().dio),
          ),
          RepositoryProvider<CharacterCache>(
            create: (_) => HiveCharacterCache(characterBox),
          ),
          RepositoryProvider<GetCharsRepo>(
            create: (context) => GetCharsRepo(api: context.read<ApiClient>()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CharsBloc>(
              create:
                  (context) => CharsBloc(
                    repo: context.read<GetCharsRepo>(),
                    cache: context.read<CharacterCache>(),
                  )..add(GetAllChars()),
            ),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                title: 'Rick and Morty',
                debugShowCheckedModeBanner: false,
                theme: context.watch<ThemeProvider>().theme,
                home: const MainScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
