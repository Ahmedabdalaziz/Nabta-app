import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/repo/disease_detction_repo.dart';
import 'package:meta/meta.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  final PlantDiseaseDetectionRepository repository;

  DiseaseCubit(this.repository) : super(DiseaseInitial());

  String? _cachedPlantType;
  String? _cachedImage;

  void cacheDiseaseData(String plantType, String image) {
    _cachedPlantType = plantType;
    _cachedImage = image;
    emit(DiseaseDataCached());
  }

  String? getCachedImage() {
    return _cachedImage;
  }

  Future<void> submitDiseaseData() async {
    if (_cachedPlantType == null || _cachedImage == null) {
      emit(DiseaseFailure(message: "No data cached to submit."));
      return;
    }

    emit(DiseaseLoading());

    try {
      final response =
      await repository.detectDisease(_cachedPlantType!, _cachedImage!);
      emit(DiseaseSuccess(response));

      _cachedPlantType = null;
      _cachedImage = null;
    } catch (e) {
      emit(DiseaseFailure(message: e.toString()));
    }
  }
}
