import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState> {
  AnimalCubit() : super(AnimalInitial());
}
