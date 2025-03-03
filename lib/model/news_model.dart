class NewsModel {
  String title;
  String description;
  String url;
  String imageUrl;
  String source;
  String publishedAt;
  final String content;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.content,
  });

  // Convert JSON to NewsModel
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['image'] ?? '',
      source: json['source']['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? json['description'] ?? 'No Content Available',
    );
  }

  // Convert Map (from Database) to NewsModel
  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'] ?? 'No title',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      source: map['source'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }

  // Convert NewsModel to Map (for saving in Database)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
      'source': source,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
