import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../data/api/api_client.dart';
import 'episodes_event.dart';
import 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final ApiClient _api;

  EpisodesBloc(this._api) : super(EpisodesInitial()) {
    on<FetchEpisodes>(_onFetch);
  }

  Future<void> _onFetch(
    FetchEpisodes event,
    Emitter<EpisodesState> emit,
  ) async {
    emit(EpisodesLoading());
    try {
      final episodes = await _api.getEpisodes();
      emit(EpisodesLoaded(episodes));
    } on DioException catch (e) {
      emit(EpisodesError(e.message ?? 'Network error'));
    } catch (e) {
      emit(EpisodesError(e.toString()));
    }
  }
}
