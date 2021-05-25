import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breaking_bad_api/bloc_quotas/quotas_barrel.dart';
import 'package:breaking_bad_api/models/quotes/quotes.dart';
import 'package:breaking_bad_api/repositories/quotes_repo.dart';

class QuotasBloc extends Bloc<QuotasEvent, QuotasState> {
  final QuotesRepo quotesRepo;

  QuotasBloc({required this.quotesRepo}) : super(QuotasInitialState());

  @override
  Stream<QuotasState> mapEventToState(
    QuotasEvent event,
  ) async* {
    if (event is QuotasRequestedEvent) {
      yield QuotasLoadInProgressState();
      try {
        final List<Quotes> quotes = await quotesRepo.getQuote(event.author);
        yield QuotasLoadSuccessState(quotes: quotes);
      } catch (e) {
        print(e);
        yield QuotasLoadFailureState();
      }
    }
  }
}
