import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/characters/characters_bloc.dart';
import 'bloc/characters/characters_event.dart';
import 'bloc/episodes/episodes_bloc.dart';
import 'bloc/episodes/episodes_event.dart';
import 'bloc/locations/locations_bloc.dart';
import 'bloc/locations/locations_event.dart';
import 'data/api/api_client.dart';
import 'router/app_router.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiClient();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharactersBloc(api)..add(FetchCharacters()),
        ),
        BlocProvider(
          create: (_) => LocationsBloc(api)..add(FetchLocations()),
        ),
        BlocProvider(
          create: (_) => EpisodesBloc(api)..add(FetchEpisodes()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rick & Morty Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
