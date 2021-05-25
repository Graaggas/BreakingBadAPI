import 'package:equatable/equatable.dart';

abstract class QuotasEvent extends Equatable {
  const QuotasEvent();

  // @override
  // List<Object> get props => [];
}

class QuotasRequestedEvent extends QuotasEvent {
  final String author;

  QuotasRequestedEvent({required this.author});

  @override
  List<Object> get props => [
        author,
      ];
}
