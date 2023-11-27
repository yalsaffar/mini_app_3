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
   Future<List<TVShow>> getTrendingTVShows() async {
    final response = await http.get(Uri.parse('$baseUrl/trending/tv/day?api_key=$apiKey'));
    return _processResponse(response, (json) => TVShow.fromJson(json));
  }
Future<List<dynamic>> searchMulti(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/multi?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      var results = json.decode(response.body)['results'] as List;
      return results.map((result) {
        if (result['media_type'] == 'movie') {
          return Movie.fromJson(result);
        } else if (result['media_type'] == 'tv') {
          return TVShow.fromJson(result);
        } else if (result['media_type'] == 'person') {
          return Actor.fromJson(result);
        }
        return null; // or throw an error if you encounter an unsupported type
      }).where((item) => item != null).toList(); // Remove nulls from the list
    } else {
      throw Exception('Failed to load search results');
    }
  }
Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results for movies');
    }
  }

  Future<List<TVShow>> searchTVShows(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => TVShow.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results for TV shows');
    }
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
