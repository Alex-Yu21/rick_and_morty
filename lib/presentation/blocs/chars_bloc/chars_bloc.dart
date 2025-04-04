import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/results_hive_model.dart';

part 'chars_event.dart';
part 'chars_state.dart';

class CharsBloc extends Bloc<CharsEvent, CharsState> {
  final GetCharsRepo repo;

  int currentPage = 1;
  bool hasNextPage = true;
  List<Results> _allResults = [];

  CharsBloc({required this.repo}) : super(CharsInitial()) {
    on<GetAllChars>(_onGetAllChars);
  }

  Future<void> _onGetAllChars(
    GetAllChars event,
    Emitter<CharsState> emit,
  ) async {
    final box = Hive.box<ResultsHiveModel>('cached_chars');

    if (event.page == 1) {
      final cached = box.values.map((e) => e.toResults()).toList();
      if (cached.isNotEmpty) {
        _allResults = cached;
        emit(CharsLoaded(CharacterModel(results: cached)));
      } else {
        emit(CharsLoading());
      }
    }

    try {
      debugPrint('[CharsBloc] Запрос страницы: ${event.page}');

      final characterModel = await repo.getData(page: event.page);

      currentPage = event.page;
      hasNextPage = characterModel.info?.next != null;

      if (event.page == 1) {
        _allResults = characterModel.results ?? [];

        await box.clear();
        for (var c in _allResults) {
          if (c.id != null) {
            box.put(c.id, ResultsHiveModel.fromResults(c));
          }
        }
      } else {
        _allResults += characterModel.results ?? [];
      }

      emit(
        CharsLoaded(
          CharacterModel(info: characterModel.info, results: _allResults),
        ),
      );

      debugPrint(
        '[CharsBloc] Всего загружено: ${_allResults.length} персонажей',
      );
    } catch (e, stackTrace) {
      debugPrint('[CharsBloc] Ошибка: $e');
      debugPrint('[CharsBloc] Стек: $stackTrace');

      if (state is! CharsLoaded) {
        emit(CharsError('Не удалось загрузить данные'));
      }
    }
  }
}
