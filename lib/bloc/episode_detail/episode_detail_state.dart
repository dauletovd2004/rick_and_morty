import '../../data/models/character.dart';

abstract class EpisodeDetailState {}

class EpisodeDetailLoading extends EpisodeDetailState {}

class EpisodeDetailLoaded extends EpisodeDetailState {
  final List<Character> characters;
  EpisodeDetailLoaded(this.characters);
}

class EpisodeDetailError extends EpisodeDetailState {
  final String message;
  EpisodeDetailError(this.message);
}
