import '../../data/models/location.dart';

abstract class LocationDetailEvent {}

class LoadLocationResidents extends LocationDetailEvent {
  final Location location;
  LoadLocationResidents(this.location);
}
