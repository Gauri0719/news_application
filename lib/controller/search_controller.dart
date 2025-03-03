import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_application/model/news_model.dart';
import 'package:news_application/services/news_services.dart';

// import '../models/news_model.dart';

class NewsSearchController extends GetxController {
  var searchText = ''.obs; // Observable search text
  var newsList = <NewsModel>[].obs; // Observable list of news
  var isLoading = false.obs; // Observable loading state

  // final String apiKey = 'YOUR_GNEWS_API_KEY';

  void fetchNews(String query) async {
    if (query.isEmpty) return;

    try {
      isLoading.value = true;
      List<NewsModel> articles = await NewsService.fetchNews(query);
      newsList.value = articles;}
    catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchText(String value) {
    searchText.value = value;
    fetchNews(value); // Fetch news dynamically as the user types
  }
}
