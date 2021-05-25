import 'package:breaking_bad_api/models/person/person.dart';
import 'package:breaking_bad_api/repositories/api_client.dart';

class PeopleRepo {
  final APIClient apiClient;

  PeopleRepo({required this.apiClient});

  Future<Person> getPeople(int id) async {
    return apiClient.fetchPersonAPI(id);
  }
}
