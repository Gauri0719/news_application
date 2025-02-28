
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/category_controller.dart';

class HomePage extends GetView<CategoryController>{
  final CategoryController categoryController=Get.put(CategoryController());
   HomePage({super.key});
final List<String> categories = ['General','Business','Technology','Sports','Entertainment','Health','Science'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
           DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'News App',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Stay informed',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.more_time),
              title: Text('Reading History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.sunny),
              title: Text('Dark Mode'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // body: Center(child: Text('Swipe from left or tap the menu icon')),
      body: Column(
          children: [
          SizedBox(height: 10),
      Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            bool isSelected = categoryController.selectedCategory.value == category;
            return GestureDetector(
              onTap: () {
                categoryController.selectCategory(category);
                },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.purple : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    if (isSelected)
                      Icon(Icons.check, color: Colors.white, size: 18),
                    SizedBox(width: isSelected ? 5 : 0),
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      )),


    ]));

  }

}
