import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:news_application/controllers/search_controller.dart';
import 'package:news_application/model/news_model.dart';
import 'package:news_application/controller/search_controller.dart' as custom;

class SearchPage extends StatelessWidget {
  final custom.SearchController searchController = Get.put(custom.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Search News"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController.searchTextController,
              onChanged: (value) => searchController.fetchSearchResults(),
              decoration: InputDecoration(
                hintText: "Search for news...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (searchController.searchResults.isEmpty) {
                return Center(child: Text("No results found"));
              }

              return ListView.builder(
                itemCount: searchController.searchResults.length,
                itemBuilder: (context, index) {
                  NewsModel news = searchController.searchResults[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: news.imageUrl.isNotEmpty
                                ? Image.network(news.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover)
                                : Container(height: 200, color: Colors.grey[300], child: Icon(Icons.image, size: 50)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  news.description ?? '',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      news.source,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    Text(
                                      news.publishedAt,
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )

        ],
      ),
    );
  }
}
