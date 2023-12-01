import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../providers/user_session_data.dart';
import 'package:provider/provider.dart';
import '../screens/movie_detailed_screen.dart';
import '../screens/tv_show_detailed_screen.dart';

class WatchlistCard extends StatelessWidget {
  final int itemId;

  WatchlistCard({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final userSessionData = Provider.of<UserSessionData>(context, listen: false);
    Movie? movie = userSessionData.getMovieById(itemId);
    TVShow? tvShow = userSessionData.getTVShowById(itemId);

    return InkWell(
      onTap: () => _navigateToDetails(context, movie, tvShow, userSessionData),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the movie or TV show image
            Image.network(
              movie?.posterUrl ?? tvShow?.posterUrl ?? 'https://via.placeholder.com/150',
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie?.title ?? tvShow?.name ?? 'Title not found',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // Add any additional information you want to display here
                ],
              ),
            ),
          ],
        ),
      ),
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
