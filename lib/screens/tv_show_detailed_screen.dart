import 'package:flutter/material.dart';
import '../models/tv_show.dart';
import '../models/user_review.dart';
import '../providers/user_session_data.dart';
import 'package:provider/provider.dart';

class TVShowDetailsScreen extends StatefulWidget {
  final TVShow tvShow;

  TVShowDetailsScreen({required this.tvShow});

  @override
  _TVShowDetailsScreenState createState() => _TVShowDetailsScreenState();
}

class _TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  bool isAddedToWatchlist = false;
  double userRating = 0.0;
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final existingReview = Provider.of<UserSessionData>(context, listen: false).getReviewForItem(widget.tvShow.id);
    if (existingReview != null && !existingReview.isMovie) {
      reviewController.text = existingReview.review;
      userRating = existingReview.rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tvShow.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.tvShow.posterUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'First Air Date: ${_formatDate(widget.tvShow.firstAirDate)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${widget.tvShow.rating.toStringAsFixed(1)}/10',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Overview:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.tvShow.overview,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add to Watchlist:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    isAddedToWatchlist
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      isAddedToWatchlist = !isAddedToWatchlist;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Your Rating:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  color: userRating >= 1 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    _setUserRating(1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: userRating >= 2 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    _setUserRating(2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: userRating >= 3 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    _setUserRating(3);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: userRating >= 4 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    _setUserRating(4);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: userRating >= 5 ? Colors.amber : Colors.grey,
                  onPressed: () {
                    _setUserRating(5);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Your Review:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your review here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveReview(context);
                },
                child: Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
void _saveReview(BuildContext context) {
    final review = UserReview(
      itemID: widget.tvShow.id.toString(),
      review: reviewController.text,
      rating: userRating,
      title: widget.tvShow.name,
      posterUrl: widget.tvShow.posterUrl,
      isMovie: false, // This is for a TV show, not a movie
    );

    Provider.of<UserSessionData>(context, listen: false).addReview(widget.tvShow.id, review);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review added!')));
  }
  String _formatDate(DateTime? date) {
    if (date != null) {
      return date.toLocal().toString().split(' ')[0];
    }
    return 'Unknown';
  }

  void _setUserRating(double rating) {
    setState(() {
      userRating = rating;
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
