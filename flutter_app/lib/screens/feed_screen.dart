import 'package:flutter/material.dart';
import 'package:today_workout/component/feed_card.dart';

import '../dummy/data/feed.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here you would build your feed list
    return ListView.builder(
      itemCount: feedItems.length,
      itemBuilder: (context, index) {
        return FeedCard(feedItem: feedItems[index]);
      },
    );
  }
}
