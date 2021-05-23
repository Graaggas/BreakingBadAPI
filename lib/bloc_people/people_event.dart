import 'package:equatable/equatable.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class PeopleRequestedEvent extends PeopleEvent {
  final int id;

  PeopleRequestedEvent({
    required this.id,
  }) : assert(id != null);

  @override
  List<Object> get props => [
        id,
      ];
}
