import 'package:breaking_bad_api/models/peoples/people_barrel.dart';
import 'package:breaking_bad_api/repositories/api_client.dart';
import 'package:meta/meta.dart';

class PeopleRepo {
  final APIClient apiClient;

  PeopleRepo({required this.apiClient}) : assert(apiClient != null);

  Future<People> getPeople(int id) async {
    return apiClient.fetchPeopleAPI(id);
  }
}
