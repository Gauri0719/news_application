import 'package:get/get.dart';

class CategoryController extends GetxController{
  var selectedCategory = 'General'.obs;
  var categoryList=[].obs;

  void selectCategory(String category){
    selectedCategory.value = category;
  }
}