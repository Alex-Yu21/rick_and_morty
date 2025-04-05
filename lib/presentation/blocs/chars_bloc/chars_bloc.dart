import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/models/character.dart';

part 'chars_event.dart';
part 'chars_state.dart';

class CharsBloc extends Bloc<CharsEvent, CharsState> {
  CharsBloc({required this.repo}) : super(CharsInitial()) {
    on<GetAllChars>((event, emit) async {
      emit(CharsLoading());

      try {
        debugPrint('[CharsBloc] Запрос данных...');

        final characterModel = await repo.getData();

        debugPrint(
          '[CharsBloc] Загружено: ${characterModel.results?.length} персонажей',
        );

        emit(CharsLoaded(characterModel));
      } catch (e, stackTrace) {
        debugPrint('[CharsBloc] Ошибка: $e');
        debugPrint('[CharsBloc] Стек: $stackTrace');

        emit(CharsError('Network error'));
      }
    });
  }

  final GetCharsRepo repo;
}
