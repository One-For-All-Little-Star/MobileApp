class Alphabet {
  final String letter;
  final bool isLock;
  final int numOfstars;

  Alphabet({
    required this.letter,
    this.isLock = true,
    this.numOfstars = 0,
  }) : super();

  factory Alphabet.fromJson(Map<String, dynamic> json) {
    return Alphabet(
        letter: json['letter'],
        isLock: json['isLock'],
        numOfstars: json['numOfStars']);
  }
}
