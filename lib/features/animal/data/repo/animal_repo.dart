import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';

import '../model/animal_response.dart';

class AnimalRepository {
  final ApiService apiService;

  AnimalRepository(this.apiService);
// waiting for response name and method name
  Future<AnimalResponse> getAllAnimals(String token) async {
    try {
      // same as previous comment
      final AnimalResponse = await apiService.getAllAnimals('bearer $token');
      return AnimalResponse;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
