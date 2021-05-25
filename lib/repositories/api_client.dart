import 'dart:convert';

import 'package:breaking_bad_api/models/quotes/quotes.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:breaking_bad_api/models/peoples/people_barrel.dart';

class APIClient {
  static const baseUrl = 'https://www.breakingbadapi.com/api';

  final http.Client httpClient;

  APIClient({
    required this.httpClient,
  }) : assert(httpClient != null);

  Future<People> fetchPeopleAPI(int id) async {
    final mainUrl = '$baseUrl/characters/$id/';

    final peopleResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (peopleResponse.statusCode != 200) {
      throw Exception('error getting people with id');
    }
    final peopleJson = jsonDecode(peopleResponse.body);
    return People.fromJson(peopleJson[0]);
  }

  Future<Quotes> fetchQuoteApi(String author) async {
    final mainUrl = '$baseUrl/quote?author=$author';

    final quotesResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (quotesResponse.statusCode != 200) {
      throw Exception('error getting quote with author');
    }
    final quoteJson = jsonDecode(quotesResponse.body);

    return Quotes.fromJason(quoteJson[0]);
  }
}
