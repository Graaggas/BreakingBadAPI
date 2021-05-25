import 'package:breaking_bad_api/models/quotes/quotes.dart';
import 'package:breaking_bad_api/repositories/api_client.dart';

class QuotesRepo {
  final APIClient apiClient;

  QuotesRepo({
    required this.apiClient,
  });

  Future<List<Quotes>> getQuote(String author) async {
    return apiClient.fetchQuoteApi(author);
  }
}
