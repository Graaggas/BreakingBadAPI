import 'package:breaking_bad_api/models/characters/characters_barrel.dart';
import 'package:equatable/equatable.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitialState extends CharactersState {}

class CharactersLoadInProgressState extends CharactersState {}

class CharactersLoadFailureState extends CharactersState {}

class CharactersLoadSuccessState extends CharactersState {
  final Characters characters;

  CharactersLoadSuccessState({required this.characters});

  @override
  List<Object> get props => [
        characters,
      ];
}
