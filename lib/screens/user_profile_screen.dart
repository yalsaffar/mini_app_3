import 'package:flutter/material.dart';
import 'package:mini_app_3/models/user_review.dart';
import 'package:mini_app_3/screens/rated_moives_tv_shows_screen.dart';
import 'package:mini_app_3/screens/watch_list_screen.dart';
import 'package:mini_app_3/widgets/movie_card.dart';
import 'package:mini_app_3/widgets/review_card.dart';
import 'package:mini_app_3/widgets/tv_show_card.dart';
import 'package:mini_app_3/widgets/watchlist_card.dart';
import '../providers/user_session_data.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../screens/movie_detailed_screen.dart';
import '../screens/tv_show_detailed_screen.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionData = Provider.of<UserSessionData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen or show settings modal
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(context, userSessionData),
          Divider(height: 30),
          _buildSectionTitle(context, 'My Watchlist', () {
            // Navigate to watchlist screen
          }),
          _buildWatchlist(context, userSessionData),
          Divider(height: 30),
          _buildSectionTitle(context, 'My Rated Movies/Shows', () {
            // Navigate to rated movies/shows screen
          }),
          _buildRatedList(context, userSessionData),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserSessionData userData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with user's profile image URL
          ),
          SizedBox(height: 8),
          Text(
            'Username', // Replace with user's username
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'Bio goes here', // Replace with user's bio
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to edit profile screen
            },
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onTapSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          
        ],
      ),
    );
  }
Widget _buildWatchlist(BuildContext context, UserSessionData userData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Watchlist',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WatchListScreen()),
                );
              },
              child: Text('See all'),
            ),
          ],
        ),
      ),
      Container(
        height: 200,
        child: userData.watchlist.isEmpty
            ? Center(child: Text('Your watchlist is empty'))
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userData.watchlist.length,
                itemBuilder: (context, index) {
                  int itemId = userData.watchlist[index];
                  return WatchlistCard(itemId: itemId);
                },
              ),
      ),
    ],
  );
}



Widget _buildRatedList(BuildContext context, UserSessionData userData) {
  var reviewedItems = userData.reviews.values.toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RatedMoviesTvShowsScreen()),
            );
          },
          child: Text('See all'),
        ),
      ),
      Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: reviewedItems.length,
          itemBuilder: (BuildContext context, int index) {
            UserReview review = reviewedItems[index];
            return ReviewCard(
              review: review,
              onTap: () => _navigateToDetails(context, review, userData),
            );
          },
        ),
      ),
    ],
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
