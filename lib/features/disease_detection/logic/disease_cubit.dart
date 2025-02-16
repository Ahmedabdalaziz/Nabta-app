import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/repo/disease_detction_repo.dart';
import 'package:meta/meta.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  final PlantDiseaseDetectionRepository repository;

  DiseaseCubit(this.repository) : super(DiseaseInitial());

  String? _cachedPlantType;
  String? _cachedImage;

  void cacheDiseaseData(String plantType, String image) {
    print(
        '🔹 Caching Data - Plant: $plantType, Image: ${image.substring(0, 50)}...');
    _cachedPlantType = plantType;
    _cachedImage = image;
    emit(DiseaseDataCached());
  }

  Future<void> submitDiseaseData() async {
    if (_cachedPlantType == null || _cachedImage == null) {
      print('⚠️ No cached data to submit!');
      emit(DiseaseFailure(message: "No data cached to submit."));
      return;
    }

    print(
        '📤 Submitting data - Plant: $_cachedPlantType, Image: ${_cachedImage!.substring(0, 50)}...');
    emit(DiseaseLoading());

    try {
      final response =
          await repository.detectDisease(_cachedPlantType!, _cachedImage!);
      print('✅ Received Response: $response');
      emit(DiseaseSuccess(response));

      _cachedPlantType = null;
      _cachedImage = null;
    } catch (e) {
      print('❌ Error submitting data: $e');
      emit(DiseaseFailure(message: e.toString()));
    }
  }
}
