import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitialState extends PersonState {}

class PersonLoadInProgressState extends PersonState {}

class PersonLoadFailureState extends PersonState {}

class PersonLoadSuccessState extends PersonState {
  final Person person;

  PersonLoadSuccessState({
    required this.person,
  });

  @override
  List<Object> get props => [person];
}
