import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../data/api/api_client.dart';
import 'characters_event.dart';
import 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final ApiClient _api;

  CharactersBloc(this._api) : super(CharactersInitial()) {
    on<FetchCharacters>(_onFetch);
  }

  Future<void> _onFetch(
    FetchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final characters = await _api.getCharacters();
      emit(CharactersLoaded(characters));
    } on DioException catch (e) {
      emit(CharactersError(e.message ?? 'Network error'));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
