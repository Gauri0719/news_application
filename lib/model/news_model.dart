class NewsModel {
  String title;
  String description;
  String url;
  String image;
  String source;
  String publishedAt;
  final int? id;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.source,
    required this.publishedAt,
    this.id
  });

  // Convert object to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'image': image,
      'source': source,
      'publishedAt': publishedAt,
      'id': id,
    };
  }
  ///THIS CONVERT JSON INTO DART
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      source: json['source']['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      id: json['id'],
    );
  }
}
