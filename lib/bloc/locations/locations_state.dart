import '../../data/models/location.dart';

abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class LocationsLoading extends LocationsState {}

class LocationsLoaded extends LocationsState {
  final List<Location> locations;
  LocationsLoaded(this.locations);
}

class LocationsError extends LocationsState {
  final String message;
  LocationsError(this.message);
}
