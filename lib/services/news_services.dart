import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_application/model/news_model.dart';

class NewsService {
  static const String _baseUrl = "https://gnews.io/api/v4";
  static const String _apiKey = "f8b8f3716b1dc9e9638f4f7f1bca765b"; // Replace with your key

  // Fetch news by category
  static Future<List<NewsModel>> fetchNews(String category) async {
    try {
      final String apiUrl = "$_baseUrl/top-headlines?category=$category&lang=en&token=$_apiKey";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('articles') && jsonData['articles'] is List) {
          List<dynamic> articles = jsonData['articles'];
          return articles.map((json) => NewsModel.fromJson(json)).toList();
        } else {
          throw Exception("Invalid response format: No articles found.");
        }
      } else {
        throw Exception("Failed to load news. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news by category: $e");
      return [];
    }
  }

  // Fetch news by search query
  static Future<List<NewsModel>> searchNews(String query) async {
    try {
      final String apiUrl = "$_baseUrl/search?q=$query&lang=en&token=$_apiKey";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('articles') && jsonData['articles'] is List) {
          List<dynamic> articles = jsonData['articles'];
          return articles.map((json) => NewsModel.fromJson(json)).toList();
        } else {
          throw Exception("Invalid response format: No articles found.");
        }
      } else {
        throw Exception("Failed to load search results. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching search results: $e");
      return [];
    }
  }
}
