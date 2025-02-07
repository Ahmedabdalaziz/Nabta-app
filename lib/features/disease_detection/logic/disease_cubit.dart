import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/disease_detection/data/models/plant_disease_detection_models.dart';
import 'package:graduation_project/features/disease_detection/data/repo/disease_detction_repo.dart';
import 'package:meta/meta.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  final PlantDiseaseDetectionRepository repository;

  DiseaseCubit(this.repository) : super(DiseaseInitial());

  Future<void> detectDisease(String plantType, String image) async {
    emit(DiseaseLoading());
    try {
      final response = await repository.detectDisease(plantType, image);
      emit(DiseaseSuccess(response));
    } catch (e) {
      emit(DiseaseFailure(message: e.toString()));
    }
  }
}
