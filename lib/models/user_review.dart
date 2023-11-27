class UserReview {
  final String movieOrTvShowId; // You can use this to identify the associated movie or TV show
  final String review;
  final double rating;

  UserReview({
    required this.movieOrTvShowId,
    required this.review,
    required this.rating,
  });
}
