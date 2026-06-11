import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/episodes/episodes_bloc.dart';
import '../bloc/episodes/episodes_event.dart';
import '../bloc/episodes/episodes_state.dart';
import '../data/models/episode.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          if (state is EpisodesLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }
          if (state is EpisodesError) {
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
                          context.read<EpisodesBloc>().add(FetchEpisodes()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is EpisodesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.episodes.length,
              itemBuilder: (context, index) =>
                  _EpisodeCard(episode: state.episodes[index]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final Episode episode;
  const _EpisodeCard({required this.episode});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Text(
            episode.episode,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        title: Text(
          episode.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(episode.airDate),
      ),
    );
  }
}
