import 'package:hive/hive.dart';
part 'alphabet.g.dart';

@HiveType(typeId: 1)
class Alphabet {
  Alphabet({
    required this.letter,
    required this.image,
    this.isLock = true,
    this.numOfstars = 0,
  });
  @HiveField(0)
  final String letter;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final bool isLock;
  @HiveField(3)
  final int numOfstars;

  @override
  String toString() {
    return "Chữ $letter: $numOfstars";
  }

  factory Alphabet.fromJson(Map<String, dynamic> json) {
    return Alphabet(
        letter: json['letter'],
        image: json['image'],
        isLock: json['isLock'],
        numOfstars: json['numOfStars']);
  }
}
