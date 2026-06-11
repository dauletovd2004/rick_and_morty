import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/locations/locations_bloc.dart';
import '../bloc/locations/locations_event.dart';
import '../bloc/locations/locations_state.dart';
import '../data/models/location.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          if (state is LocationsLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }
          if (state is LocationsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<LocationsBloc>().add(FetchLocations()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is LocationsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.locations.length,
              itemBuilder: (context, index) =>
                  _LocationCard(location: state.locations[index]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final Location location;
  const _LocationCard({required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.location_on, color: Colors.green),
        ),
        title: Text(
          location.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${location.type} · ${location.dimension}'),
      ),
    );
  }
}
