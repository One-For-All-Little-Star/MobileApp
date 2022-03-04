class Video {
  final String name;
  final String link;
  final String thumbnail;
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
