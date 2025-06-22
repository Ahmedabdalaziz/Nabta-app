import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/animal/data/model/animal_response.dart';
import 'package:graduation_project/features/animal/data/repo/animal_repo.dart';
import 'package:meta/meta.dart';

import '../../../core/helper/token.dart';

part 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState> {
  AnimalCubit(this.animalRepository) : super(AnimalInitial());

  AnimalRepository animalRepository ;
  String ? token;
  AnimalResponse? _cachedAnimalResponse;

  Future<void> fetchAnimals() async {
    if (_cachedAnimalResponse != null) {
      emit(AnimalSuccess(_cachedAnimalResponse!));
      return;
    }

    emit(AnimalLoading());
    try {
      token ??= await _getToken();

      final AnimalResponse = await animalRepository.getAllAnimals(token!);
      _cachedAnimalResponse = AnimalResponse;
      emit(AnimalSuccess(AnimalResponse));
    } on Exception catch (e) {
      emit(AnimalFaild(e.toString()));
    }
  }

  Future<String?> _getToken() async {
    final TokenManager tokenManager = TokenManager();
    return await tokenManager.getToken();
  }

  void clearCache() {
    _cachedAnimalResponse = null;
  }



}
