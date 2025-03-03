import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/controller/search_controller.dart';
import 'package:news_application/home_page.dart';
import 'package:news_application/controller/theme_controller.dart';

void main() {
  Get.put(ThemeController()); // Initialize Theme Controller
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Light Theme
      darkTheme: ThemeData.dark(), // Dark Theme
      themeMode:
      themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
        // Get.lazyPut(()=>NewsSearchController()),
      home: HomePage(),
    ));
  }
}
