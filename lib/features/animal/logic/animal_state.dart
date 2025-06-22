part of 'animal_cubit.dart';

@immutable
sealed class AnimalState {}

final class AnimalInitial extends AnimalState {}

final class AnimalFaild extends AnimalState{
  String errorMessage;

  AnimalFaild(this.errorMessage);
}

final class AnimalLoading extends AnimalState{}


final class AnimalSuccess extends AnimalState{
  AnimalResponse animalResponse;
  AnimalSuccess(this.animalResponse);
}