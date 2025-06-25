import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant/plant_disease_detection_models.dart';
import 'package:retrofit/retrofit.dart';

part 'disease_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.urlDetectDisease)
abstract class PlantDiseaseApiService {
  factory PlantDiseaseApiService(Dio dio) {
    return _PlantDiseaseApiService(dio);
  }

  @POST("predict")
  @MultiPart()
  Future<PlantDiseaseDetectionResponseModel> detectDisease(
    @Part(name: "plant_type") String plantType,
    @Part(name: "image") File imageFile,
  );
}
