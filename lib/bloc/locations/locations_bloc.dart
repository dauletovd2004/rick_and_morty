import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../data/api/api_client.dart';
import 'locations_event.dart';
import 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final ApiClient _api;

  LocationsBloc(this._api) : super(LocationsInitial()) {
    on<FetchLocations>(_onFetch);
  }

  Future<void> _onFetch(
    FetchLocations event,
    Emitter<LocationsState> emit,
  ) async {
    emit(LocationsLoading());
    try {
      final locations = await _api.getLocations();
      emit(LocationsLoaded(locations));
    } on DioException catch (e) {
      emit(LocationsError(e.message ?? 'Network error'));
    } catch (e) {
      emit(LocationsError(e.toString()));
    }
  }
}
