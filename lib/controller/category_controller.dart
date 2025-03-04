
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
// import '../model/news_model.dart';
import '../services/news_services.dart';

class NewsController extends GetxController {
  var isLoading = false.obs;
  var selectedCategory = "general".obs;
  var newsList = <NewsModel>[].obs;
  var searchResults = <NewsModel>[].obs;

  // Fetch news by category
  Future<void> fetchNewsByCategory(String category) async {
    try {
      isLoading(true);
      selectedCategory.value = category;
      var news = await NewsService.fetchNews(category);
      newsList.assignAll(news);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }


}
