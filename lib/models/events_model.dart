class Event {
  final String name;
  final String description;
  final String location;
  final String month;
  final String date;
  final String day;
  final String time;
  final String image;

  Event(
      {required this.name,
      required this.description,
      required this.location,
      required this.date,
      required this.day,
      required this.time,
      required this.image,
      required this.month});
}
