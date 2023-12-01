import 'package:flutter/material.dart';
import '../providers/user_session_data.dart';
import '../widgets/review_card.dart';
import '../screens/movie_detailed_screen.dart';
import '../screens/tv_show_detailed_screen.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../models/user_review.dart';
class RatedMoviesTvShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionData = Provider.of<UserSessionData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rated Movies and TV Shows'),
      ),
      body: ListView.builder(
        itemCount: userSessionData.reviews.length,
        itemBuilder: (context, index) {
          var review = userSessionData.reviews.values.elementAt(index);
          return ReviewCard(
            review: review,
            onTap: () {
              _navigateToDetails(context, review, userSessionData);
            },
          );
        },
      ),
    );
  }

  void _navigateToDetails(BuildContext context, UserReview review, UserSessionData userSessionData) {
  int itemId = int.parse(review.itemID);
  if (review.isMovie) {
    Movie? movie = userSessionData.getMovieById(itemId);
    if (movie != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Movie not found')));
    }
  } else {
    TVShow? tvShow = userSessionData.getTVShowById(itemId);
    if (tvShow != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TVShowDetailsScreen(tvShow: tvShow)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('TV show not found')));
    }
  }
}

}
