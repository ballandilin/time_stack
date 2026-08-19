class ChronoModel {
  int id;
  String label;
  Duration elapsed;
  bool isRunning;
  DateTime? startTime;

  ChronoModel({
    required this.id,
    required this.label,
    this.elapsed = Duration.zero,
    this.isRunning = false,
    this.startTime,
  });
}
