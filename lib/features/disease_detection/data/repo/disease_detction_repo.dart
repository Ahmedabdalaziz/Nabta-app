import 'package:graduation_project/features/disease_detection/data/models/plant/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/remote/disease_api_service.dart';
import 'dart:io';

class PlantDiseaseDetectionRepository {
  final PlantDiseaseApiService apiService;

  PlantDiseaseDetectionRepository(this.apiService);

  Future<PlantDiseaseDetectionResponseModel> detectDisease(
      String plantType, File imageFile) async {
    try {
      final response = await apiService.detectDisease(plantType, imageFile);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}