// // import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_application/services/news_services.dart';
// import '../model/news_model.dart';
// // import '../services/api_service.dart';
//
// class SearchController extends GetxController {
//   TextEditingController searchTextController = TextEditingController();
//   var searchResults = <NewsModel>[].obs;
//   var isLoading = false.obs;
//
//   void searchNews(String query) async {
//     if (query.isEmpty) {
//       searchResults.clear();
//       return;
//     }
//     isLoading.value = true;
//     try {
//       var results = await NewsService.fetchNews(query);
//       searchResults.assignAll(results as Iterable<NewsModel>);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
