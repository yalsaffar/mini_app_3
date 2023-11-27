import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/actor.dart';
import '../models/tv_show.dart';

class TMDBService {
  final String apiKey = 'api';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'));
    return _processResponse(response, (json) => Movie.fromJson(json));
  }

  Future<List<Actor>> searchActors(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/person?api_key=$apiKey&query=$query'));
    return _processResponse(response, (json) => Actor.fromJson(json));
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'));
    return _processResponseSingle(response, (json) => Movie.fromJson(json));
  }

  Future<TVShow> getTVShowDetails(int tvShowId) async {
    final response = await http.get(Uri.parse('$baseUrl/tv/$tvShowId?api_key=$apiKey'));
    return _processResponseSingle(response, (json) => TVShow.fromJson(json));
  }

  // Utility method to process list responses
  List<T> _processResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Utility method to process single item responses
  T _processResponseSingle<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
