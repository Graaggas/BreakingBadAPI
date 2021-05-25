import 'package:equatable/equatable.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();
}

class PersonRequestedEvent extends PersonEvent {
  final int id;

  PersonRequestedEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}
