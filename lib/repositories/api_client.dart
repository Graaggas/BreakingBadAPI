import 'dart:convert';
import 'package:breaking_bad_api/models/characters/characters.dart';
import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:breaking_bad_api/models/quotes/quotes.dart';
import 'package:http/http.dart' as http;

class APIClient {
  static const baseUrl = 'https://www.breakingbadapi.com/api';

  final http.Client httpClient;

  APIClient({
    required this.httpClient,
  });

  Future<Person> fetchPersonAPI(int id) async {
    final mainUrl = '$baseUrl/characters/$id/';

    final peopleResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (peopleResponse.statusCode != 200) {
      throw Exception('error getting people with id');
    }
    final peopleJson = jsonDecode(peopleResponse.body);
    return Person.fromJson(peopleJson[0]);
  }

  Future<List<Quotes>> fetchQuoteApi(String author) async {
    final mainUrl = '$baseUrl/quote?author=$author';

    final quotesResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (quotesResponse.statusCode != 200) {
      throw Exception('error getting quote with author');
    }
    // final quoteJson = jsonDecode(quotesResponse.body);

    List<Quotes> quotesList = (json.decode(quotesResponse.body) as List)
        .map((e) => Quotes.fromJason(e))
        .toList();
    return quotesList;
  }

  Future<Characters> fetchCharactersAPI() async {
    final mainUrl = '$baseUrl/characters';

    final charactersResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (charactersResponse.statusCode != 200) {
      throw Exception('error getting characters');
    }

    final characters = jsonDecode(charactersResponse.body);

    return Characters.fromJson(characters);
  }
}
