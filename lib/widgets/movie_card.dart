import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detailed_screen.dart';


class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigate to MovieDetailsScreen when the card is clicked
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: movie),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                movie.posterUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Release Date: ${_formatDate(movie.releaseDate)}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 20, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        '${movie.rating.toStringAsFixed(1)}/10',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          // Implement logic to add to watchlist
                        },
                      ),
                      // Add more buttons or actions here
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatDate(DateTime? date) {
    if (date != null) {
      return date.toLocal().toString().split(' ')[0]; // Format date as yyyy-mm-dd
    }
    return 'Unknown'; // Or any placeholder text you prefer
  }
}