import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../widgets/movie_card.dart';
import '../widgets/tv_show_card.dart';
import '../widgets/actor_card.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../models/actor.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TMDBService _tmdbService = TMDBService();
  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;
  Future<List<Movie>>? _searchResultsMovies;
  Future<List<TVShow>>? _searchResultsTVShows;
  Future<List<Actor>>? _searchResultsActors;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _search(String query) {
    if (query.isNotEmpty) {
      setState(() {
        // Separate the search queries by type
        _searchResultsMovies = _tmdbService.searchMovies(query);
        _searchResultsTVShows = _tmdbService.searchTVShows(query);
        _searchResultsActors = _tmdbService.searchActors(query);
        // Implement searchMovies, searchTVShows, and searchActors in your TMDBService
      });
    }
  }

  Widget _buildSearchResults<T>(Future<List<T>>? searchResults, Widget Function(T) buildFunction) {
    return FutureBuilder<List<T>>(
      future: searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => buildFunction(snapshot.data![index]),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies, TV shows, actors...',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onSubmitted: _search,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Movies'),
            Tab(text: 'TV Shows'),
            Tab(text: 'Actors'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _searchResultsMovies == null
              ? Center(child: Text('Search for movies'))
              : _buildSearchResults(_searchResultsMovies, (movie) => MovieCard(movie: movie as Movie)),
          _searchResultsTVShows == null
              ? Center(child: Text('Search for TV shows'))
              : _buildSearchResults(_searchResultsTVShows, (tvShow) => TVShowCard(tvShow: tvShow as TVShow)),
          _searchResultsActors == null
              ? Center(child: Text('Search for actors'))
              : _buildSearchResults(_searchResultsActors, (actor) => ActorCard(actor: actor as Actor)),
        ],
      ),
    );
  }
}
