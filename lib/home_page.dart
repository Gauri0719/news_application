import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:news_application/news_detail_page.dart';

import 'controller/category_controller.dart';

class HomePage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  final TextEditingController searchController = TextEditingController();

  // HomePage({super.key});
  final List<String> categories = [
    'General',
    'Business',
    'Technology',
    'Sports',
    'Entertainment',
    'Health',
    'Science'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News App"),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context,
                      delegate: NewsSearchDelegate(newsController));
                },
                icon: Icon(Icons.search))
          ],
        ),
        drawer: _buildDrawer(context),
        body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() =>Row(
                      children: categories.map((category) {
                        bool isSelected = newsController.selectedCategory.value ==category.toLowerCase();

                        return GestureDetector(
                          onTap: ()=>newsController.fetchNewsByCategory(category.toLowerCase()),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.purple : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                if (isSelected) // ✅ Show icon only if selected
                                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                                if (isSelected) SizedBox(width: 5),
                                SizedBox(width: 5,),
                                Text(category,style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),)
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                  ),
                ),
              ),
              // NEWS LIST
              Expanded(child: Obx(() {
                if (newsController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: newsController.newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsController.newsList[index];
                      return NewsCard(news: news);
                    });
              })
              )
            ])
    );
  }

}
// DRAWER MENU
Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("News App", style: TextStyle(color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),),
              Text("Stay informed",
                style: TextStyle(color: Colors.white70, fontSize: 14,),),

            ],
          ),
        ),
        _drawerItem(Icons.home, "Home", () {
          Get.back();
        }),
        _drawerItem(Icons.history, "Reading History", () {

        }),
        Divider(),
        ListTile(
          leading: Icon(Icons.sunny),
          title: Text("Dark Mode"),

        )
      ],
    ),
  );
}
// Drawer Item Widget
Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: onTap,
  );
}
// SEARCH DELEGATE FOR SEARCHING NEWS
class NewsSearchDelegate extends SearchDelegate {
  final NewsController newsController;

  NewsSearchDelegate(this.newsController);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = newsController.newsList.where((news) =>
        news.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(itemCount: results.length,
      itemBuilder: (context, index) => NewsCard(news: results[index]),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
// CATEGORY BUTTON WIDGET
class CategoryButton extends StatelessWidget {
  final String category;
  final NewsController controller;

  CategoryButton({required this.category, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => controller.fetchNewsByCategory(category),
        child: Text(category.toUpperCase())
    );
  }
}
// NEWS CARD WIDGET
class NewsCard extends StatelessWidget {
  final NewsModel news;

  NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> NewsDetailPage(news : news));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
            children: [
              news.image != null
                  ? Image.network(news.image!, fit: BoxFit.cover,
                width: double.infinity,
                height: 200,)
                  : Container(height: 200, color: Colors.grey,),
              Padding(padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news.title, style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(news.description, maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(news.source, style: TextStyle(color: Colors.blue),),
                        Text(
                          news.publishedAt, style: TextStyle(color: Colors.grey),)
                      ],
                    )
                  ],
                ),
              )
            ]

        ),
      ),
    );
  }
}