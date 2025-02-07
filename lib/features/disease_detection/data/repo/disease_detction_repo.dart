import 'package:graduation_project/features/disease_detection/data/models/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/remote/disease_api_service.dart';

class PlantDiseaseDetectionRepository {
  final PlantDiseaseApiService apiService;

  PlantDiseaseDetectionRepository(this.apiService);

  Future<PlantDiseaseDetectionResponseModel> detectDisease(
      String plantType, String image) async {
    try {
      final response = await apiService.detectDisease(plantType, image);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
