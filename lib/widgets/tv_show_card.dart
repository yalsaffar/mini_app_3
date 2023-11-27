import 'package:flutter/material.dart';
import '../models/tv_show.dart';

class TVShowCard extends StatelessWidget {
  final TVShow tvShow;

  TVShowCard({required this.tvShow});

  @override
  Widget build(BuildContext context) {
    // Helper function to format the date or return a default string
    String formattedDate(DateTime? date) {
      if (date != null) {
        return date.toLocal().toString().split(' ')[0];
      } else {
        return 'Unknown'; // or any default message you'd like to use
      }
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              tvShow.posterUrl,
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
                  tvShow.name,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'First Air Date: ${formattedDate(tvShow.firstAirDate)}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 20, color: Colors.amber),
                    SizedBox(width: 4),
                    Text(
                      '${tvShow.rating.toStringAsFixed(1)}/10',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Seasons: ${tvShow.numberOfSeasons}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                // Add more details as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
