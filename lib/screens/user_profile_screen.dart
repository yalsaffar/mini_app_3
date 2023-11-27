import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Padding(
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
                Divider(height: 30),
                _buildSectionTitle(context, 'My Watchlist'),
                _buildWatchlist(),
                Divider(height: 30),
                _buildSectionTitle(context, 'My Rated Movies/Shows'),
                _buildRatedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          TextButton(
            onPressed: () {
              // Navigate to full watchlist or rated list
            },
            child: Text('See all'),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlist() {
    // This should be a horizontal list view showing posters of movies/TV shows in the watchlist
    return Container(
      height: 200, // Adjust as needed
      // Replace with a ListView.builder that builds MovieCard/TVShowCard widgets
      child: Placeholder(),
    );
  }

  Widget _buildRatedList() {
    // This should be a horizontal list view showing posters and ratings of movies/TV shows rated by the user
    return Container(
      height: 200, // Adjust as needed
      // Replace with a ListView.builder that builds MovieCard/TVShowCard widgets with rating displayed
      child: Placeholder(),
    );
  }
}
