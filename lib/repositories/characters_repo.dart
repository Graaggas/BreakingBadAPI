import 'package:breaking_bad_api/models/characters/characters_barrel.dart';
import 'package:breaking_bad_api/repositories/repositories_barrel.dart';

class CharactersRepo {
  final APIClient apiClient;

  CharactersRepo({required this.apiClient});

  Future<Characters> getCharacters() async {
    return apiClient.fetchCharactersAPI();
  }
}
