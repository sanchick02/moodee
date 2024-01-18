class TherapistAvailability {
  final String date;
  final List<String> timings;
  bool isSelected;

  TherapistAvailability({
    required this.date,
    required this.timings,
    this.isSelected = false,
  });
}
