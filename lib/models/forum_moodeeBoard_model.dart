// ignore: file_names
class ForumMoodeeBoard {
  final String userImage;
  final String name;
  final String time;
  final String caption;
  final String? postImage;

  ForumMoodeeBoard(
      {required this.userImage,
      required this.name,
      required this.time,
      required this.caption,
      this.postImage});
}
