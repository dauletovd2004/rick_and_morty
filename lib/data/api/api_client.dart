import 'package:dio/dio.dart';
import '../models/character.dart';
import '../models/location.dart';
import '../models/episode.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Character>> getCharacters() async {
    final response = await _dio.get('/character');
    final results = response.data['results'] as List<dynamic>;
    return results.map((e) => Character.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Location>> getLocations() async {
    final response = await _dio.get('/location');
    final results = response.data['results'] as List<dynamic>;
    return results.map((e) => Location.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Episode>> getEpisodes() async {
    final response = await _dio.get('/episode');
    final results = response.data['results'] as List<dynamic>;
    return results.map((e) => Episode.fromJson(e as Map<String, dynamic>)).toList();
  }
}
