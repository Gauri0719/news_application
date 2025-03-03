//
// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_application/controller/search_controller.dart' as app_search;
//
//
// class SearchPage extends StatelessWidget {
//   final app_search.SearchController searchController = Get.put(app_search.SearchController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: searchController.searchTextController,
//           onChanged: (value) {
//             searchController.searchNews(value);
//           },
//           decoration: InputDecoration(
//             hintText: 'Search for news...',
//             border: InputBorder.none,
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (searchController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (searchController.searchResults.isEmpty) {
//           return Center(child: Text('No results found.'));
//         }
//         return ListView.builder(
//           itemCount: searchController.searchResults.length,
//           itemBuilder: (context, index) {
//             final news = searchController.searchResults[index];
//             return ListTile(
//               title: Text(news.title),
//               subtitle: Text(news.description ?? ''),
//               onTap: () {
//                 Get.toNamed('/newsDetail', arguments: news);
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }
