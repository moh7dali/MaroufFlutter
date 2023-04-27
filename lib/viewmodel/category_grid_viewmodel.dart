import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/brand_categories_model.dart';
import '../models/home_model.dart';
import '../utils/helper.dart';

class CategoryGridViewModel extends GetxController {
  int page = 1;
  int limit = 10;
  bool internetConnection = false;

  bool hasNextPage = true;

  bool isFirstLoadRunning = true;

  bool isLoadMoreRunning = false;

  late ScrollController scrollController;

  List<RootCategories> selectedSubCategories = [];

  final int categoryId;

  CategoryGridViewModel(this.categoryId);

  @override
  void onInit() {
    super.onInit();
    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  firstLoad() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getSubCategory}?parentCategoryId=$categoryId&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
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

  void _loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      page += 1;

      await HttpClientApp().request(
        method: 'GET',
        url: '${APIUrls.getSubCategory}?parentCategoryId=$categoryId&pageNumber=$page',
        body: {},
        files: {},
      ).then((response) async {
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
        update();});
    }
  }

  Future<void> refreshScreen() async {
    page = 1;
    limit = 10;
    internetConnection = false;
    hasNextPage = true;
    isFirstLoadRunning = false;
    isLoadMoreRunning = false;
    selectedSubCategories = [];
    update();
    firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    isFirstLoadRunning = true;
    update();
    scrollController.removeListener(_loadMore);
    super.dispose();
  }

}
