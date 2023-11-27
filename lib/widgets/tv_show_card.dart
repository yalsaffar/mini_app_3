class TVShow {
  final int id;
  final String name;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final DateTime firstAirDate;
  final double rating;
  final List<String> genres;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  TVShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.firstAirDate,
    required this.rating,
    required this.genres,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
  });

  // Factory method to create a TVShow instance from JSON data
  factory TVShow.fromJson(Map<String, dynamic> json) {
    List<String> genres = [];
    if (json['genres'] != null) {
      genres = List<String>.from(json['genres'].map((genre) => genre['name']));
    }

    return TVShow(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      backdropUrl: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      firstAirDate: DateTime.parse(json['first_air_date']),
      rating: json['vote_average'].toDouble(),
      genres: genres,
      numberOfSeasons: json['number_of_seasons'],
      numberOfEpisodes: json['number_of_episodes'],
    );
  }
}
