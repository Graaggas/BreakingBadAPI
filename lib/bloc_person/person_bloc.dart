import 'dart:async';
import 'package:breaking_bad_api/bloc_person/blocs_barrel.dart';
import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:breaking_bad_api/repositories/repositories_barrel.dart';
import 'package:bloc/bloc.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PeopleRepo peopleRepo;

  PersonBloc({
    required this.peopleRepo,
  }) : super(PersonInitialState());

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    if (event is PersonRequestedEvent) {
      yield PersonLoadInProgressState();
      try {
        final Person person = await peopleRepo.getPeople(event.id);
        yield PersonLoadSuccessState(person: person);
      } catch (e) {
        print("error : $e");
        yield PersonLoadFailureState();
      }
    }
  }
}
