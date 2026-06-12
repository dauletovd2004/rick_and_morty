import '../../data/models/episode.dart';

abstract class EpisodeDetailEvent {}

class LoadEpisodeDetail extends EpisodeDetailEvent {
  final Episode episode;
  LoadEpisodeDetail(this.episode);
}
