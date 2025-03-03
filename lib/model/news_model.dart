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
    required this.content
  });

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
}
