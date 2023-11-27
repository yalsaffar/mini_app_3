import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';

class MoviePopularScreen extends StatefulWidget {
  @override
  _MoviePopularScreenState createState() => _MoviePopularScreenState();
}

class _MoviePopularScreenState extends State<MoviePopularScreen> {
  final TMDBService _tmdbService = TMDBService();
  late Future<List<Movie>> _popularMoviesFuture;

  @override
  void initState() {
    super.initState();
    _popularMoviesFuture = _tmdbService.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _popularMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No popular movies found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
