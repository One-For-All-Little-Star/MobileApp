import 'package:hive/hive.dart';

part 'time_use.g.dart';

@HiveType(typeId: 3)
class TimeUse {
  TimeUse({
    required this.day,
    required this.watchVideo,
    required this.learn,
  }) : super();

  @HiveField(0)
  String day;
  @HiveField(1)
  num watchVideo;
  @HiveField(2)
  num learn;

  factory TimeUse.fromJson(Map<String, dynamic> json) {
    return TimeUse(
        day: json['day'], watchVideo: json['watchVideo'], learn: json['learn']);
  }
}
