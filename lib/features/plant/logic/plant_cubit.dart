import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/data/repo/plant_repo.dart';
import 'package:meta/meta.dart';

part 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit(this.plantRepository) : super(PlantInitial());

  final PlantRepository plantRepository;
  String? token;

  Future<void> fetchPlants() async {
    emit(plantLoading());
    try {
      token ??= await _getToken();

      final plantResponse = await plantRepository.getAllPlants(token!);
      emit(PlantSuccess(plantResponse));
    } on Exception catch (e) {
      emit(PlantFailed(e.toString()));
    }
  }

  Future<String?> _getToken() async {
    final TokenManager tokenManager = TokenManager();
    return await tokenManager.getToken();
  }
}