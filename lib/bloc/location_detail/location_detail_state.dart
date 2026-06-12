import '../../data/models/character.dart';

abstract class LocationDetailState {}

class LocationDetailLoading extends LocationDetailState {}

class LocationDetailLoaded extends LocationDetailState {
  final List<Character> residents;
  LocationDetailLoaded(this.residents);
}

class LocationDetailError extends LocationDetailState {
  final String message;
  LocationDetailError(this.message);
}
