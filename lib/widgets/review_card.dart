import 'package:flutter/material.dart';
import '../models/user_review.dart';
import '../screens/movie_detailed_screen.dart';
import '../screens/tv_show_detailed_screen.dart';
import '../providers/user_session_data.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
class ReviewCard extends StatelessWidget {
  final UserReview review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final itemId = int.tryParse(review.itemID);
        if (itemId != null) {
          print('Item ID: $itemId'); // Debug print

          if (review.isMovie) {
            final movie = Provider.of<UserSessionData>(context, listen: false).getMovieById(itemId);
            print('Movie: $movie'); // Debug print

            if (movie != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movie: movie),
                ),
              );
            } else {
              print('Movie not found'); // Debug print
            }
          } else {
            final tvShow = Provider.of<UserSessionData>(context, listen: false).getTVShowById(itemId);
            print('TV Show: $tvShow'); // Debug print

            if (tvShow != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TVShowDetailsScreen(tvShow: tvShow),
                ),
              );
            } else {
              print('TV Show not found'); // Debug print
            }
          }
        } else {
          print('Invalid item ID'); // Debug print
        }
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 4.0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: ListTile(
            leading: Image.network(
              review.posterUrl,
              width: 50,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            title: Text(review.title),
            subtitle: Text(review.review),
            trailing: Icon(Icons.open_in_new),
          ),
        ),
      ),
    );
  }
}
