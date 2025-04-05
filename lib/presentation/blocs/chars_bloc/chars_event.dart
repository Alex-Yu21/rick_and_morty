part of 'chars_bloc.dart';

@immutable
sealed class CharsEvent {}

class GetAllChars extends CharsEvent {
  final int page;

  GetAllChars({this.page = 1});
}
