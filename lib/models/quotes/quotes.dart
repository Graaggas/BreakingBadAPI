import 'package:equatable/equatable.dart';

class Quotes extends Equatable {
  final int id;
  final String quote;
  final String author;

  const Quotes({
    required this.id,
    required this.quote,
    required this.author,
  });

  @override
  List<Object> get props => [
        id,
        quote,
        author,
      ];

  static Quotes fromJason(dynamic json) {
    return Quotes(
      id: json['quote_id'],
      quote: json['quote'],
      author: json['author'],
    );
  }
}
