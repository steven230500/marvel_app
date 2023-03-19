class Comic {
  final int id;
  final String title;
  final String thumbnailPath;
  final String thumbnailExtension;

  Comic({
    required this.id,
    required this.title,
    required this.thumbnailPath,
    required this.thumbnailExtension,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      thumbnailPath: json['thumbnail']['path'],
      thumbnailExtension: json['thumbnail']['extension'],
    );
  }
}
