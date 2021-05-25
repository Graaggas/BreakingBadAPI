import 'dart:async';
import 'package:breaking_bad_api/bloc_people/blocs_barrel.dart';
import 'package:breaking_bad_api/models/peoples/people_barrel.dart';
import 'package:breaking_bad_api/repositories/repositories_barrel.dart';
import 'package:bloc/bloc.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleRepo peopleRepo;

  PeopleBloc({
    required this.peopleRepo,
  })   : assert(peopleRepo != null),
        super(PeopleInitialState());

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    if (event is PeopleRequestedEvent) {
      yield PeopleLoadInProgressState();
      try {
        final People people = await peopleRepo.getPeople(event.id);
        yield PeopleLoadSuccessState(people: people);
      } catch (e) {
        print("error : $e");
        yield PeopleLoadFailureState();
      }
    }
  }
}
