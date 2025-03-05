import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';

class PlantRepository{
  final ApiService apiService;

  PlantRepository(this.apiService);

  Future<PlantResponse> getAllPlants(String token) async{
    try {
      final plantResponse = await apiService.getAllPlants('bearer ${token}');
      return plantResponse;
    } on Exception catch (e) {
      throw Exception('${e.toString()}');
    }
  }


}