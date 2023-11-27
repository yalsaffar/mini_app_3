import 'package:flutter/material.dart';
import '../widgets/tv_show_card.dart';
import '../models/tv_show.dart';
import '../services/tmdb_service.dart';

class TVShowsPopularScreen extends StatefulWidget {
  @override
  _TVShowsPopularScreenState createState() => _TVShowsPopularScreenState();
}

class _TVShowsPopularScreenState extends State<TVShowsPopularScreen> {
  final TMDBService _tmdbService = TMDBService();
  late Future<List<TVShow>> _popularTVShowsFuture;

  @override
  void initState() {
    super.initState();
    _popularTVShowsFuture = _tmdbService.getTrendingTVShows(); // Make sure this method is defined in your TMDBService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: FutureBuilder<List<TVShow>>(
        future: _popularTVShowsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No popular TV shows found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TVShowCard(tvShow: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
