import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/models/all_data_model.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/brand_categories_model.dart';
import '../models/home_model.dart';
import '../models/products_model.dart';
import '../utils/helper.dart';


class CategoryProductsViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late String selectedTabTitle;
  TabController? tabController;

  late List<RootCategories> selectedSubCategories;
  List<RootCategories> brandCategories;
  RootCategories selectedCategory;
  ScrollController? scrollController;
  int page = 1;
  int limit = 10;
  bool internetConnection = false;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List<ProductItem> products = [];
  final bool? hasSubCategories;
  final dynamic productModuleId;
  final dynamic productModuleType;

  CategoryProductsViewModel(this.brandCategories, this.selectedCategory,
      {this.hasSubCategories, this.productModuleId, this.productModuleType});


  @override
  void onInit() {
    if (productModuleId != null && productModuleType != null) {
      getSelectedCategoryDetails();
    }
    selectedTabTitle = selectedCategory.name ?? "";
    tabController = TabController(
        length: brandCategories.length,
        initialIndex: brandCategories
            .indexWhere((element) => element.id == selectedCategory.id),
        vsync: this);
    refreshScreenProducts();
    tabController!.addListener(tabListener);
  }

  getSelectedCategoryDetails() async {
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.getSingleCategory}?productModuleType=$productModuleType&productModuleId=$productModuleId',
      body: {},
      files: {},
    ).then((response) async {

      AllDataModel _brandCategories =
      AllDataModel.fromJson(json.decode(response));
      selectedCategory = _brandCategories.categoryModel!;
      print('adasdas ${selectedCategory.name}');
      int i =brandCategories.indexWhere((element) => element.id == selectedCategory.id);
      brandCategories[i] = selectedCategory;
      if (categoriesStack.value.isEmpty) {
        categoriesStack.value.add(selectedCategory);
        brandsCategoriesStack.value.add([selectedCategory]);
      } else {
        categoriesStack.value = [selectedCategory];
        brandsCategoriesStack.value = [[selectedCategory]];
      }
      update();
      if (_brandCategories.isSucceeded!) {
      } else {
        if (_brandCategories.errors!.isNotEmpty) {
          Helper().errorSnackBar(_brandCategories.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }


  Future<void> refreshScreenProducts() async {
    isFirstLoadRunning = true;
    update();
    page = 1;
    limit = 10;
    internetConnection = false;
    hasNextPage = true;
    isLoadMoreRunning = false;
    products = [];
    update();
    if (selectedCategory.hasSubCategory ??
        false || (hasSubCategories != null && hasSubCategories == true)) {
      firstLoadCategory();
      scrollController = ScrollController()..addListener(_loadMoreCategory);
    } else {
      firstLoadProducts();
      scrollController = ScrollController()..addListener(_loadMoreProducts);
    }
  }

  Future<void> tabListener() async {
    selectedSubCategories = [];
    selectedCategory = brandCategories[tabController!.index];
    categoriesStack.value.last = selectedCategory;
    brandsCategoriesStack.value.last = selectedSubCategories;
    selectedCategory = selectedCategory;
    brandsCategoriesStack.value.last = brandCategories;
    categoriesStack.value.last = selectedCategory;
    refreshScreenProducts();
  }

  @override
  void dispose() {
    isFirstLoadRunning = true;
    update();
    scrollController!.removeListener(_loadMoreProducts);
    scrollController!.removeListener(_loadMoreCategory);
    super.dispose();
  }

  firstLoadProducts() async {
    print('firstLoad');
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.getProductByCategory}?categoryId=${selectedCategory.id}&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      ProductModel productsModel = ProductModel.fromJson(json.decode(response));
      products = productsModel.productItems ?? [];
      isFirstLoadRunning = false;
      update();
      if (productsModel.isSucceeded!) {
      } else {
        if (productsModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(productsModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  void _loadMoreProducts() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController!.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      page += 1;

      await HttpClientApp().request(
        method: 'GET',
        url:
        '${APIUrls.getProductByCategory}?categoryId=${selectedCategory.id}&pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
        ProductModel productsModel =
        ProductModel.fromJson(json.decode(response));
        isLoadMoreRunning = false;
        update();
        List<ProductItem> notificationList = productsModel.productItems ?? [];
        if (notificationList.isNotEmpty) {
          products.addAll(notificationList);
        } else {
          hasNextPage = false;
          update();
        }

        if (productsModel.isSucceeded!) {
        } else {
          if (productsModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(productsModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    }
  }

  firstLoadCategory() async {
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.getSubCategory}?parentCategoryId=${selectedCategory.id}&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      BrandCategories _brandCategories =
      BrandCategories.fromJson(json.decode(response));
      selectedSubCategories = _brandCategories.categoryModel!;
      update();
      if (_brandCategories.isSucceeded!) {
      } else {
        if (_brandCategories.errors!.isNotEmpty) {
          Helper().errorSnackBar(_brandCategories.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      isFirstLoadRunning = false;
      update();
    });
  }

  void _loadMoreCategory() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController!.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      page += 1;

      await HttpClientApp().request(
        method: 'GET',
        url:
        '${APIUrls.getSubCategory}?parentCategoryId=${selectedCategory.id}&pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
        print(response);
        isLoadMoreRunning = false;
        BrandCategories _brandCategories =
        BrandCategories.fromJson(json.decode(response));
        List<RootCategories> rootCategories =
            _brandCategories.categoryModel ?? [];
        update();
        if (_brandCategories.isSucceeded!) {
          if (rootCategories.isNotEmpty) {
            selectedSubCategories.addAll(rootCategories);
          } else {
            hasNextPage = false;
            update();
          }
        } else {
          if (_brandCategories.errors!.isNotEmpty) {
            Helper().errorSnackBar(_brandCategories.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
        isFirstLoadRunning = false;
        update();
      });
    } else {
      isLoadMoreRunning = false;
      update();
    }
  }
}
