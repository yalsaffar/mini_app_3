class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final DateTime releaseDate;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.rating,
  });

  // If you're fetching data from an API, you'll likely need a factory method to convert JSON into a Movie instance.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}', // Modify the URL according to your needs
      backdropUrl: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}', // Modify the URL according to your needs
      releaseDate: DateTime.parse(json['release_date']),
      rating: json['vote_average'].toDouble(),
    );
  }
}
