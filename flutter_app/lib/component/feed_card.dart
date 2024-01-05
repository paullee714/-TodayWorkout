import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'data/feed_item.dart';

class FeedCard extends StatelessWidget {
  final FeedItem feedItem;

  FeedCard({required this.feedItem});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width;
    final double imageHeight = imageWidth * 0.8;

    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // User Profile, Username, Nickname, Timestamp
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    // backgroundImage: NetworkImage(feedItem.userProfileImageUrl),
                    backgroundImage: CachedNetworkImageProvider(
                      feedItem.userProfileImageUrl,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(feedItem.username,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("@${feedItem.nickname}"),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.bookmark_border),
                    onPressed: () {}, // Implement save functionality
                  ), // Consider formatting the timestamp
                ],
              ),
            ),
            if (feedItem.imageUrl != null) ...[
              Container(
                height: imageHeight,
                width: imageWidth,
                child: CachedNetworkImage(
                  imageUrl: feedItem.imageUrl!,
                  placeholder: (context, url) => const SizedBox(
                    width: double.infinity,
                    child: Center(
                      // child: CircularProgressIndicator(
                      //   semanticsLabel: "Loading image...",
                      // ),
                      child: SpinKitWanderingCubes(
                        color: Colors.orangeAccent,
                        size: 50.0,
                        duration: const Duration(milliseconds: 2000),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ],
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(feedItem.content),
            ),
            // Like, Comment, Save Buttons and Counts
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0), // POINT
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Like and Comment Buttons
                  Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              " ${feedItem.likeCount} Likes",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.comment_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              " ${feedItem.commentCount} Comments",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Save Button
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(feedItem.timestamp),
                  ), // Consider formatting the timestamp
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
