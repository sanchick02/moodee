import 'dart:io';

class ForumPost {
  String id; //
  String userImage;
  String name;
  String time;
  String caption;
  String postImage;
  int likes;

  ForumPost(
      {required this.id,
      required this.userImage,
      required this.name,
      required this.time,
      required this.caption,
      required this.postImage,
      this.likes = 0});
}
