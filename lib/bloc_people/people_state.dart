import 'package:equatable/equatable.dart';
import 'package:breaking_bad_api/models/peoples/people_barrel.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitialState extends PeopleState {}

class PeopleLoadInProgressState extends PeopleState {}

class PeopleLoadFailureState extends PeopleState {}

class PeopleLoadSuccessState extends PeopleState {
  final People people;

  PeopleLoadSuccessState({
    required this.people,
  }) : assert(people != null);

  @override
  List<Object> get props => [people];
}
