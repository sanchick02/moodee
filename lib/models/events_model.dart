class Event {
  final String name;
  final String description;
  final String location;
  final String month;
  final String date;
  final String day;
  final String time;
  final String image;
  final String hall;
  final String eventDate;
  final String latitude;
  final String longitude;
  final List<String> eventHighlights;
  final List<String> eventImages;

  Event(
      {required this.name,
      required this.description,
      required this.location,
      required this.date,
      required this.day,
      required this.time,
      required this.image,
      required this.month,
      required this.hall,
      required this.eventDate,
      required this.eventHighlights,
      required this.latitude,
      required this.longitude,
      required this.eventImages});
}
