import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/repositories/dio_settings.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';
import 'package:rick_and_morty/presentation/blocs/chars_bloc/chars_bloc.dart';
import 'package:rick_and_morty/presentation/screens/main_screen.dart';
import 'package:rick_and_morty/presentation/providers/theme_provider.dart';
import 'package:rick_and_morty/presentation/providers/bottom_nav_provider.dart';
import 'package:rick_and_morty/presentation/providers/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ResultsHiveModelAdapter());

  await Hive.openBox<ResultsHiveModel>('favorites');
  await Hive.openBox<ResultsHiveModel>('cached_chars');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (_) => DioSettings()),
              RepositoryProvider(
                create:
                    (context) => GetCharsRepo(
                      dio: RepositoryProvider.of<DioSettings>(context).dio,
                    ),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => CharsBloc(
                        repo: RepositoryProvider.of<GetCharsRepo>(context),
                      )..add(GetAllChars()),
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
