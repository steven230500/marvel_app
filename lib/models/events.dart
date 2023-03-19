class Event {
  final int id;
  final String title;
  final String thumbnailPath;
  final String thumbnailExtension;

  Event({
    required this.id,
    required this.title,
    required this.thumbnailPath,
    required this.thumbnailExtension,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      thumbnailPath: json['thumbnail']['path'],
      thumbnailExtension: json['thumbnail']['extension'],
    );
  }
}
