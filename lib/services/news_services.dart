import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_application/model/news_model.dart';


class NewsService {
  static const String _baseUrl = "https://gnews.io/api/v4";
  static const String _apiKey = "f8b8f3716b1dc9e9638f4f7f1bca765b"; // Replace with your key

  static Future<List<NewsModel>> fetchNews(String category) async {
    final String url = '$_baseUrl/top-headlines?category=$category&lang=en&apikey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['articles'];
      return data.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
