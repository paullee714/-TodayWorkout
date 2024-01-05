class FeedItem {
  String username;
  String nickname;
  String timestamp; // Consider using a DateTime object in a real app
  String content;
  String? imageUrl;
  String userProfileImageUrl;
  int likeCount;
  int commentCount;
  int viewCount;
  int saveCount;

  FeedItem({
    required this.username,
    required this.nickname,
    required this.timestamp,
    required this.content,
    this.imageUrl,
    required this.userProfileImageUrl,
    this.likeCount = 0,
    this.commentCount = 0,
    this.viewCount = 0,
    this.saveCount = 0,
  });
}
