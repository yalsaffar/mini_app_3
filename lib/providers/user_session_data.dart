import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_app_3/models/movie.dart'; // Import your Movie model
import 'package:mini_app_3/models/tv_show.dart'; // Import your TVShow model
import 'package:mini_app_3/models/user_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/tmdb_service.dart';
class UserSessionData extends ChangeNotifier {
  List<int> watchlist = [];
  Map<int, UserReview> reviews = {};
  List<Movie> movies = []; // Assuming this is your list of movies
  List<TVShow> tvShows = []; // Assuming this is your list of TV shows
  
  UserSessionData() {
    loadReviews();
    //loadMovies(); // Call this if you're loading movies from somewhere
    //loadTVShows(); // Call this if you're loading TV shows from somewhere
  }
  TMDBService tmdbService = TMDBService();
  Movie? getMovieById(int id) {
    try {
      return movies.firstWhere((movie) => movie.id == id);
    } catch (e) {
      // Handle the case where the movie is not found
      return null;
    }
  }

  TVShow? getTVShowById(int id) {
    try {
      return tvShows.firstWhere((tvShow) => tvShow.id == id);
    } catch (e) {
      // Handle the case where the TV show is not found
      return null;
    }
  }
  

  UserReview? getReviewForItem(int itemId) {
    return reviews[itemId];
  }

  void addToWatchlist(int itemId) {
    if (!watchlist.contains(itemId)) {
      watchlist.add(itemId);
      notifyListeners();
    }
  }

  void removeFromWatchlist(int itemId) {
    if (watchlist.contains(itemId)) {
      watchlist.remove(itemId);
      notifyListeners();
    }
  }

  void addReview(int itemId, UserReview review) {
    reviews[itemId] = review;
    _saveToPrefs();
    notifyListeners();
  }

  void _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert your reviews to a JSON string
    final String reviewsJson = jsonEncode(reviews.map((key, value) => MapEntry(key.toString(), value.toJson())));
    await prefs.setString('reviews', reviewsJson);
  }

  void loadReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final String? reviewsJson = prefs.getString('reviews');
    if (reviewsJson != null) {
      Map<String, dynamic> reviewsMap = jsonDecode(reviewsJson);
      reviews.clear();
      reviewsMap.forEach((key, reviewJson) {
        int id = int.parse(key);
        UserReview review = UserReview.fromJson(reviewJson as Map<String, dynamic>);
        reviews[id] = review;
      });
      notifyListeners();
    }
  }

  Future<void> loadMovieDetails(int movieId) async {
    try {
      Movie movieDetails = await tmdbService.getMovieDetailsById(movieId);
      // Do something with movieDetails, like adding to a list or updating UI
    } catch (e) {
      print('Error loading movie details: $e');
    }
  }

  Future<void> loadTVShowDetails(int tvShowId) async {
    try {
      TVShow tvShowDetails = await tmdbService.getTVShowDetailsById(tvShowId);
      // Do something with tvShowDetails
    } catch (e) {
      print('Error loading TV show details: $e');
    }
  }
}
