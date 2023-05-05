class Story {
  final int id;
  final String title;
  final String type;

  Story({
    required this.id,
    required this.title,
    required this.type,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'],
      type: json['type'],
    );
  }
}
