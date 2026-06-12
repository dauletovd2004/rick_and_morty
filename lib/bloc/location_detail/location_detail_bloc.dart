import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/api_client.dart';
import 'location_detail_event.dart';
import 'location_detail_state.dart';

class LocationDetailBloc extends Bloc<LocationDetailEvent, LocationDetailState> {
  final ApiClient apiClient;

  LocationDetailBloc({required this.apiClient}) : super(LocationDetailLoading()) {
    on<LoadLocationResidents>(_onLoadLocationResidents);
  }

  Future<void> _onLoadLocationResidents(
    LoadLocationResidents event,
    Emitter<LocationDetailState> emit,
  ) async {
    try {
      emit(LocationDetailLoading());
      
      if (event.location.residents.isEmpty) {
        emit(LocationDetailLoaded([]));
        return;
      }
      
      final residents = await apiClient.getCharactersByUrls(
        event.location.residents,
      );
      emit(LocationDetailLoaded(residents));
    } catch (e) {
      emit(LocationDetailError('Failed to load residents: ${e.toString()}'));
    }
  }
}
