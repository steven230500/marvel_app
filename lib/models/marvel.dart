class MarvelCharacter {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;
  final List<Url> urls;

  MarvelCharacter({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.urls,
  });

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    return MarvelCharacter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      urls: (json['urls'] as List)
          .map((urlJson) => Url.fromJson(urlJson))
          .toList(),
    );
  }
}

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json['path'],
      extension: json['extension'],
    );
  }
}

class Url {
  final String type;
  final String url;

  Url({required this.type, required this.url});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'],
      url: json['url'],
    );
  }
}
