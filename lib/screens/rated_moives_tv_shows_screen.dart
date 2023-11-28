import 'package:flutter/material.dart';
import '../providers/user_session_data.dart';
import '../widgets/movie_card.dart';
import '../widgets/tv_show_card.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';

class RatedMoviesTvShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rated Movies/Shows'),
      ),
      body: Consumer<UserSessionData>(
        builder: (context, userData, child) {
          if (userData.reviews.isEmpty) {
            return Center(child: Text('No reviews yet'));
          }

          var ratedMovies = userData.reviews.values
              .where((review) => review.isMovie)
              .map((review) => userData.getMovieById(int.parse(review.itemID)))
              .whereType<Movie>()
              .toList();
          
          var ratedTVShows = userData.reviews.values
              .where((review) => !review.isMovie)
              .map((review) => userData.getTVShowById(int.parse(review.itemID)))
              .whereType<TVShow>()
              .toList();

          return ListView(
            children: [
              _buildSection('Movies', ratedMovies),
              _buildSection('TV Shows', ratedTVShows),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return item is Movie ? MovieCard(movie: item) : TVShowCard(tvShow: item);
          },
        ),
      ],
    );
  }
}
