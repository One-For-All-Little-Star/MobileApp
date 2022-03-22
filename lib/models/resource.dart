import 'package:hive/hive.dart';
part 'resource.g.dart';

@HiveType(typeId: 2)
class Resource {
  Resource({
    required this.gold,
    required this.star,
  }) : super();

  @HiveField(0)
  int gold;
  @HiveField(1)
  int star;

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(gold: json['gold'], star: json['star']);
  }
}
