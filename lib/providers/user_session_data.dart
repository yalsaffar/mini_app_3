import 'package:flutter/material.dart';
import 'package:mini_app_3/models/user_review.dart';

class UserSessionData extends ChangeNotifier {
  List<int> watchlist = [];
  Map<int, UserReview> reviews = {};

  void addToWatchlist(int itemId) {
    if (!watchlist.contains(itemId)) {
      watchlist.add(itemId);
      notifyListeners();
    }
  }

  void removeFromWatchlist(int itemId) {
    if (watchlist.contains(itemId)) {
      watchlist.remove(itemId);
      notifyListeners();
    }
  }

  void addReview(int itemId, UserReview review) {
    reviews[itemId] = review;
    notifyListeners();
  }
}
