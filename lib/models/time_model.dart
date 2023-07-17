class TimeModel {
  final DateTime startTime;
  final DateTime endTime;
  late bool isBooked;
  late bool isSelected;

  TimeModel({
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    required this.isSelected,
  });
}
