import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:breaking_bad_api/bloc_characters/characters_barrel.dart';
import 'package:breaking_bad_api/models/characters/characters_barrel.dart';
import 'package:breaking_bad_api/repositories/characters_repo.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepo charactersRepo;
  CharactersBloc({required this.charactersRepo})
      : super(CharactersInitialState());

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is CharactersRequestedEvent) {
      yield CharactersLoadInProgressState();
      try {
        final Characters characters = await charactersRepo.getCharacters();
        yield CharactersLoadSuccessState(characters: characters);
      } catch (e) {
        print(e);
        yield CharactersLoadFailureState();
      }
    }
  }
}
