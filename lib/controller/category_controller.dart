import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:news_application/services/news_services.dart';

class NewsController extends GetxController{
  var newsList = <NewsModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory='general'.obs;

  @override
  void onInit(){
    fetchNewsByCategory(selectedCategory.value);
    super.onInit();
  }

  Future<void> fetchNewsByCategory(String category) async {
    try{
      isLoading(true);
      selectedCategory.value=category;
      var news = await NewsService.fetchNews(category);
      newsList.assignAll(news);
    }catch(e){
      print("Error:$e");
    }finally{
      isLoading(false);
    }
  }
}