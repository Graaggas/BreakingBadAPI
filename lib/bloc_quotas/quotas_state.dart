import 'package:breaking_bad_api/models/quotes/quotes.dart';
import 'package:equatable/equatable.dart';

abstract class QuotasState extends Equatable {
  const QuotasState();

  @override
  List<Object> get props => [];
}

class QuotasInitialState extends QuotasState {}

class QuotasLoadInProgressState extends QuotasState {}

class QuotasLoadFailureState extends QuotasState {}

class QuotasLoadSuccessState extends QuotasState {
  final List<Quotes> quotes;

  QuotasLoadSuccessState({
    required this.quotes,
  });

  @override
  List<Object> get props => [
        quotes,
      ];
}
