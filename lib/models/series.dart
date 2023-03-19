class Series {
  final int id;
  final String title;
  final String thumbnailPath;
  final String thumbnailExtension;

  Series({
    required this.id,
    required this.title,
    required this.thumbnailPath,
    required this.thumbnailExtension,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'],
      title: json['title'],
      thumbnailPath: json['thumbnail']['path'],
      thumbnailExtension: json['thumbnail']['extension'],
    );
  }
}
