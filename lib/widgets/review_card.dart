import 'package:flutter/material.dart';
import '../models/user_review.dart';

class ReviewCard extends StatelessWidget {
  final UserReview review;
  final VoidCallback onTap;

  ReviewCard({required this.review, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              review.posterUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Your Rating: ${review.rating.toStringAsFixed(1)}/5',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'General Rating: ${review.rating.toStringAsFixed(1)}/10',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
