import 'package:equatable/equatable.dart';

class People extends Equatable {
  final int charId;
  final String name;
  final String birthday;
  final List<String> occupation;
  final String img;
  final String status;
  final String nickname;
  final List<int> appearance;
  final String portrayed;
  final String category;
  final List<int> betterCallSaulAppearance;

  const People({
    required this.charId,
    required this.name,
    required this.birthday,
    required this.occupation,
    required this.img,
    required this.status,
    required this.nickname,
    required this.appearance,
    required this.portrayed,
    required this.category,
    required this.betterCallSaulAppearance,
  });

  @override
  List<Object> get props => [
        charId,
        name,
        birthday,
        occupation,
        img,
        status,
        nickname,
        appearance,
        portrayed,
        category,
        betterCallSaulAppearance,
      ];

  static People fromJson(dynamic json) {
    return People(
      charId: json['char_id'],
      name: json['name'],
      birthday: json["birthday"],
      occupation: List<String>.from(json["occupation"].map((x) => x)),
      img: json["img"],
      status: json["status"],
      nickname: json["nickname"],
      appearance: List<int>.from(json["appearance"].map((x) => x)),
      portrayed: json["portrayed"],
      category: json["category"],
      betterCallSaulAppearance:
          List<int>.from(json["better_call_saul_appearance"].map((x) => x)),
    );
  }
}
