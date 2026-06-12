import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/api_client.dart';
import 'episode_detail_event.dart';
import 'episode_detail_state.dart';

class EpisodeDetailBloc extends Bloc<EpisodeDetailEvent, EpisodeDetailState> {
  final ApiClient apiClient;

  EpisodeDetailBloc({required this.apiClient}) : super(EpisodeDetailLoading()) {
    on<LoadEpisodeDetail>(_onLoadEpisodeDetail);
  }

  Future<void> _onLoadEpisodeDetail(
    LoadEpisodeDetail event,
    Emitter<EpisodeDetailState> emit,
  ) async {
    try {
      emit(EpisodeDetailLoading());
      
      if (event.episode.characters.isEmpty) {
        emit(EpisodeDetailLoaded([]));
        return;
      }
      
      final characters = await apiClient.getCharactersByUrls(
        event.episode.characters,
      );
      emit(EpisodeDetailLoaded(characters));
    } catch (e) {
      emit(EpisodeDetailError('Failed to load episode details: ${e.toString()}'));
    }
  }
}
