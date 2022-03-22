import 'package:hive/hive.dart';
part 'alphabet.g.dart';

@HiveType(typeId: 1)
class Alphabet {
  Alphabet({
    required this.letter,
    required this.image,
    this.isLock = true,
    this.numOfstars = 0,
    required this.routeName,
  });
  @HiveField(0)
  final String letter;
  @HiveField(1)
  final String image;
  @HiveField(2)
  bool isLock;
  @HiveField(3)
  int numOfstars;
  @HiveField(4)
  final String routeName;

  @override
  String toString() {
    return "Chữ $letter: $numOfstars";
  }

  factory Alphabet.fromJson(Map<String, dynamic> json) {
    return Alphabet(
      letter: json['letter'],
      image: json['image'],
      isLock: json['isLock'],
      numOfstars: json['numOfStars'],
      routeName: json['routeName'],
    );
  }
}
