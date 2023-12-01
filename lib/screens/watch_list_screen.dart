import 'package:flutter/material.dart';
import '../providers/user_session_data.dart';
import '../widgets/watch_list_page_card.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionData = Provider.of<UserSessionData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Watchlist'),
      ),
      body: userSessionData.watchlist.isEmpty
          ? Center(child: Text('Your watchlist is empty'))
          : ListView.builder(
              itemCount: userSessionData.watchlist.length,
              itemBuilder: (context, index) {
                int itemId = userSessionData.watchlist[index];
                return WatchlistPageCard(itemId: itemId);
              },
            ),
    );
  }
}
