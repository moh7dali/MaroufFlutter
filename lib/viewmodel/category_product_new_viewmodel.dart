import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/brand_categories_model.dart';
import '../models/home_model.dart';
import '../utils/helper.dart';

class CategoryProductNewViewModel extends GetxController with GetSingleTickerProviderStateMixin {
  final int categoryId;
  final String name;
  final bool hasSubCategories;
  late BrandCategories selectedSubCategories;
  TabController? tabController;
  late RootCategories   selectedCategory;
  bool isLoading = true;

  CategoryProductNewViewModel(this.categoryId, this.name, this.hasSubCategories);

  @override
  void onInit() {
    super.onInit();
    if(hasSubCategories){
      getSubCategory();

    }else{

    }
  }

  Future<void> tabListener() async {
    selectedCategory = selectedSubCategories.categoryModel![tabController!.index];
    categoriesStack.value.last = selectedCategory;
    brandsCategoriesStack.value.last = selectedSubCategories.categoryModel!;
    selectedCategory = selectedCategory;
    brandsCategoriesStack.value.last =  selectedSubCategories.categoryModel!;
    categoriesStack.value.last = selectedCategory;
    update();
  }

  getSubCategory() async {
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.getSubCategory}?parentCategoryId=$categoryId&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      if (kDebugMode) {
        print(response);
      }
      selectedSubCategories = BrandCategories.fromJson(json.decode(response));
      selectedCategory = selectedSubCategories.categoryModel!.first;
      tabController = TabController(
          length: selectedSubCategories.categoryModel!.length,
          initialIndex: selectedSubCategories.categoryModel!
              .indexWhere((element) => element.id == selectedCategory.id),
          vsync: this );
      tabController!.addListener(tabListener);
      isLoading = false;
      update();
      if (selectedSubCategories.isSucceeded!) {
      } else {
        if (selectedSubCategories.errors!.isNotEmpty) {
          Helper()
              .errorSnackBar(selectedSubCategories.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      update();
    });
  }
}