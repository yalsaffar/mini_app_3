import 'package:flutter/material.dart';
import 'package:mini_app_3/widgets/movie_card.dart';
import 'package:mini_app_3/widgets/tv_show_card.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../providers/user_session_data.dart';
import 'package:provider/provider.dart';
import '../screens/movie_detailed_screen.dart';
import '../screens/tv_show_detailed_screen.dart';

class WatchlistPageCard extends StatelessWidget {
  final int itemId;

  WatchlistPageCard({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final userSessionData = Provider.of<UserSessionData>(context);
    final movie = userSessionData.getMovieById(itemId);
    final tvShow = userSessionData.getTVShowById(itemId);

    return InkWell(
      onTap: () {
        // Navigate to the movie or TV show detail screen
      },
      child: movie != null
          ? MovieCard(movie: movie)
          : tvShow != null
              ? TVShowCard(tvShow: tvShow)
              : Container(), // A fallback placeholder widget
    );
  }


  void _navigateToDetails(BuildContext context, Movie? movie, TVShow? tvShow, UserSessionData userSessionData) {
    if (movie != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)),
      );
    } else if (tvShow != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TVShowDetailsScreen(tvShow: tvShow)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item not found')));
    }
  }
}
