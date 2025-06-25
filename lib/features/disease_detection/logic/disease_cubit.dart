import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/repo/disease_detction_repo.dart';
import 'package:meta/meta.dart';
import 'dart:io';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  final PlantDiseaseDetectionRepository repository;

  DiseaseCubit(this.repository) : super(DiseaseInitial());

  String? _cachedPlantType;
  File? _cachedImageFile;

  void cacheDiseaseData(String plantType, String imagePath) {
    _cachedPlantType = plantType;
    _cachedImageFile = File(imagePath);
    emit(DiseaseDataCached());
  }

  File? getCachedImageFile() {
    return _cachedImageFile;
  }

  Future<void> submitDiseaseData() async {
    emit(DiseaseLoading());
    try {
      final response = await repository.detectDisease(_cachedPlantType!, _cachedImageFile!);

      emit(DiseaseSuccess(response));

      _cachedPlantType = null;
      _cachedImageFile = null;
    } catch (e) {
      emit(DiseaseFailure(message: e.toString()));
    }
  }
}