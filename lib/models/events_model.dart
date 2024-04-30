class Event {
  final String name;
  final String description;
  final String location;
  final String month;
  final String date;
  final String day;
  final String time;
  final String image;
  final List<String> eventHighlights;
  final List<String> eventImages;
  final String moodCategory;

  Event(
      {required this.name,
      required this.description,
      required this.location,
      required this.date,
      required this.day,
      required this.time,
      required this.image,
      required this.month,
      required this.eventHighlights,
      required this.eventImages,
      required this.moodCategory});
}
