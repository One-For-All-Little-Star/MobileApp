import 'package:hive/hive.dart';

part 'video.g.dart';

@HiveType(typeId: 4)
class Video {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String link;
  @HiveField(2)
  final String thumbnail;
  @HiveField(3)
  final String description;

  Video({
    required this.name,
    required this.link,
    required this.thumbnail,
    required this.description,
  }) : super();

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        name: json['name'],
        link: json['link'],
        thumbnail: json['thumbnail'],
        description: json['description']);
  }
}
