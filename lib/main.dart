import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'widgets/movie_card.dart';
import 'services/tmdb_service.dart';
import 'models/movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TMDBService tmdbService = TMDBService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Tracker App',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trending Movies'),
        ),
        body: FutureBuilder<List<Movie>>(
          future: tmdbService.getTrendingMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No movies found.'));
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
      ),
    );
  }
}
