import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isAddedToWatchlist = false;
  double userRating = 0.0;
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.movie.posterUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Release Date: ${_formatDate(widget.movie.releaseDate)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${widget.movie.rating.toStringAsFixed(1)}/10',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Overview:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.movie.overview,
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
                  // Implement logic to save the user's rating and review
                  // You can access the userRating and reviewController.text values here
                },
                child: Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
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
