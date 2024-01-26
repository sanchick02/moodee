class ForumPost {
  String id; // Unique ID for each post
  String title;
  String subject;
  String topic;
  int likes;

  ForumPost(
      {required this.id,
      required this.title,
      required this.subject,
      required this.topic,
      this.likes = 0});
}
