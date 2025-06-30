import 'package:graduation_project/core/networking/api_service.dart';

import '../model/animal_response.dart';

class AnimalRepository {
  final ApiService apiService;

  AnimalRepository(this.apiService);
  Future<AnimalResponse> getAllAnimals(String token) async {
    try {
      final AnimalResponse = await apiService.getAllAnimals('bearer $token');
      return AnimalResponse;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
