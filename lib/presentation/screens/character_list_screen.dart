import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/chars_bloc/chars_bloc.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharsBloc>().add(GetAllChars(page: 1));
    });
    _setupScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final bloc = context.read<CharsBloc>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          bloc.hasNextPage) {
        bloc.add(GetAllChars(page: bloc.currentPage + 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharsBloc, CharsState>(
      builder: (context, state) {
        if (state is CharsLoaded) {
          final characters = state.characterModel.results ?? [];

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CharsBloc>().add(GetAllChars(page: 1));
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCard(character: character);
              },
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
