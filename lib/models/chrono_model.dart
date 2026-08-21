class ChronoModel {
  final int id;
  static const String idKey = "id";

  String label;
  static const String labelKey = "label";

  Duration elapsed;
  static const String elapsedKey = "elapsed";

  bool isRunning;
  static const String isRunningKey = "isRunning";

  DateTime? startTime;
  static const String startTimeKey = "startTime";

  ChronoModel({
    required this.id,
    required this.label,
    this.elapsed = Duration.zero,
    this.isRunning = false,
    this.startTime,
  });

  set setLabel(String lb) => label = lb;
  set setElapsed(Duration elpd) => elapsed = elpd;

  factory ChronoModel.fromJson(Map<String, dynamic> jsonData) {
    return ChronoModel(
      id: jsonData[idKey] ?? 0,
      label: jsonData[labelKey] ?? "",
      elapsed: jsonData[elapsedKey] != null
          ? Duration(milliseconds: jsonData[elapsedKey])
          : Duration.zero,
      isRunning: jsonData[isRunningKey] ?? false,
      startTime: DateTime.parse(jsonData[startTimeKey]),
    );
  }

  Map<String, dynamic> toJson() => {
    idKey: id,
    labelKey: label,
    elapsedKey: elapsed.inMilliseconds,
    isRunningKey: isRunning,
    startTimeKey:
        startTime?.toIso8601String() ?? DateTime.now().toIso8601String(),
  };
}
