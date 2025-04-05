part of 'chars_bloc.dart';

@immutable
sealed class CharsState {}

class CharsInitial extends CharsState {}

class CharsLoading extends CharsState {}

class CharsLoaded extends CharsState {
  final CharacterModel characterModel;

  CharsLoaded(this.characterModel);
}

class CharsError extends CharsState {
  final String message;

  CharsError(this.message);
}
