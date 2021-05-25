import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class CharactersRequestedEvent extends CharactersEvent {
  @override
  List<Object?> get props => [];
}
