import 'package:flutter/material.dart';
import 'package:rick_and_morty/app.dart';
import 'package:rick_and_morty/services/init_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const RickandMorty());
}
