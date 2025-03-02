class NewsModel {
  String title;
  String description;
  String url;
  String image;
  String source;
  String publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.source,
    required this.publishedAt,
  });
  ///THIS CONVERT JSON INTO DART
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      source: json['source']['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
