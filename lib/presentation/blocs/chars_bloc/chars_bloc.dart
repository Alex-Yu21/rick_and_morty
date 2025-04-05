import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/models/character.dart';

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
    if (!hasNextPage && event.page != 1) return;

    if (event.page == 1) emit(CharsLoading());

    try {
      debugPrint('[CharsBloc] Запрос страницы: ${event.page}');

      final characterModel = await repo.getData(page: event.page);

      currentPage = event.page;
      hasNextPage = characterModel.info?.next != null;

      if (event.page == 1) {
        _allResults = characterModel.results ?? [];
      } else {
        _allResults += characterModel.results ?? [];
      }

      debugPrint(
        '[CharsBloc] Всего загружено: ${_allResults.length} персонажей',
      );

      emit(
        CharsLoaded(
          CharacterModel(info: characterModel.info, results: _allResults),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('[CharsBloc] Ошибка: $e');
      debugPrint('[CharsBloc] Стек: $stackTrace');

      emit(CharsError('Network error'));
    }
  }
}
