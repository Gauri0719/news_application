import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:news_application/services/news_services.dart';
// import 'package:news_application/services/news_api_service.dart'; // Replace with your API service class

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  RxList<NewsModel> searchResults = <NewsModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(() {
      fetchSearchResults();
    });

  }

  void fetchSearchResults() async {
    String query = searchTextController.text.trim();
    if (query.isEmpty) {
      print("Query is empty");
      return;
    }

    try {
      isLoading(true);
      print("Fetching news for query: $query");  // ✅ Debugging print
      var results = await NewsService.fetchNewsByQuery(query);
      print("API Response: ${results.length} articles found");  // ✅ Debugging print

      searchResults.assignAll(results);
    } catch (e) {
      print("Error fetching search results: $e");
    } finally {
      isLoading(false);
    }
  }


  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
