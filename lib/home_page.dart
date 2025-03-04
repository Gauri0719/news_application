import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/controller/search_controller.dart';
import 'package:news_application/controller/theme_controller.dart';
import 'package:news_application/date.dart';
import 'package:news_application/model/news_model.dart';
// import 'package:news_application/model/news_model.dart';
// import '../controllers/search_controller.dart';
import 'package:news_application/news_detail_page.dart';
import 'package:news_application/reading_history_page.dart';
import 'package:news_application/search_page.dart';

import 'controller/category_controller.dart';

class HomePage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  final ThemeController themeController = Get.find();
  //  final NewsSearchController searchController =  Get.put(NewsSearchController());
  // final TextEditingController searchTextController = TextEditingController();

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
            backgroundColor: themeController.isDarkMode.value ? Colors.black : Colors.blue,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => SearchPage());
                  },
                  icon: Icon(Icons.search)),
            ]
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
                            if (isSelected) //  Show icon only if selected
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
  final ThemeController themeController = Get.find();
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: themeController.isDarkMode.value ? Colors.black : Colors.deepPurple,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "News App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Stay informed",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        _drawerItem(Icons.home, "Home", () {
          Get.back();
        }),
        _drawerItem(Icons.history, "Reading History", () {
          Get.to(() => ReadingHistoryPage());
        }),
        Divider(),
        Obx(() => ListTile(
          leading: Icon(
            themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
            color: themeController.isDarkMode.value ? Colors.yellow : Colors.black,
          ),
          title: Text(themeController.isDarkMode.value ? "Light Mode" : "Dark Mode"),
          trailing: Switch(
              value: themeController.isDarkMode.value,
              onChanged: (value){
                themeController.toggleTheme();
              }),

        ),),
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

  const NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => NewsDetailPage(), arguments: news);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
            children: [
              news.imageUrl != null
                  ? Image.network(news.imageUrl, fit: BoxFit.cover,
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
                          formatToISTDate(news.publishedAt), style: TextStyle(color: Colors.grey),)
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