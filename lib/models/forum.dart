class ForumPost {
  String uid; //
  String pid;
  String userImage;
  String userName;
  String time;
  String caption;
  String postImage;
  int likes;
  String mood;

  ForumPost({
    required this.uid,
    required this.pid,
    required this.userImage,
    required this.userName,
    required this.time,
    required this.caption,
    required this.postImage,
    required this.likes,
    required this.mood,
  });
}
