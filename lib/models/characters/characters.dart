import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:equatable/equatable.dart';

class Characters extends Equatable {
  final List<Person> characters;

  const Characters({
    required this.characters,
  });

  static Characters fromJson(List<dynamic> json) {
    List<Person> persons = <Person>[];
    persons = json.map((e) => Person.fromJson(e)).toList();
    return new Characters(characters: persons);
  }

  @override
  List<Object> get props => [
        characters,
      ];
}
