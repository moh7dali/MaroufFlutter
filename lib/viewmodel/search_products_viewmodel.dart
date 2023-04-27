import 'dart:convert';
import 'dart:developer';
import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../http/http_client.dart';
import '../models/TradeMarkModel.dart';
import '../utils/helper.dart';

class SearchOrderViewModel extends GetxController {
  int page = 1;
  int limit = 10;
  bool internetConnection = false;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List<ProductItem> products = [];

  final searchKeyController = TextEditingController();
  bool isFilters;

  SearchOrderViewModel({this.isFilters = false});

  bool isFirst=false;
  firstLoad() async {
    String query = '?pageNumber=$page&brandId=1';
    if (searchKeyController.text.isNotEmpty) {
      query += '&searchKey=${searchKeyController.text}';
    }
    String tradeMarksIds = '';
    for (var element in selectedFilters) {
      tradeMarksIds += '${element.id!},';
    }

    if (tradeMarksIds.endsWith(',')) {
      tradeMarksIds = tradeMarksIds.substring(0, tradeMarksIds.length - 1);
    }
    if (tradeMarksIds.isNotEmpty) {
      query += '&trademarkIds=$tradeMarksIds';
    }

    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.searchForProducts}$query',
      body: {},
      files: {},
    ).then((response) async {
      log(response);
      isFirstLoadRunning = false;
      ProductModel productModel = ProductModel.fromJson(json.decode(response));
      products = productModel.productItems ?? [];
      update();
      if (productModel.isSucceeded!) {
      } else {
        if (productModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(productModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
    isFirst=true;
    update();
  }

  void _loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunning = true;
      update();
      page += 1;

      String query = '?pageNumber=$page&brandId=1';
      if (searchKeyController.text.isNotEmpty) {
        query += '&searchKey=${searchKeyController.text}';
      }
      String tradeMarksIds = '';
      for (var element in selectedFilters) {
        tradeMarksIds += '${element.id!},';
      }

      if (tradeMarksIds.endsWith(',')) {
        tradeMarksIds = tradeMarksIds.substring(0, tradeMarksIds.length - 1);
      }
      if (tradeMarksIds.isNotEmpty) {
        query += '&trademarkIds=$tradeMarksIds';
      }

      await HttpClientApp().request(
        method: 'GET',
        url: '${APIUrls.searchForProducts}$query',
        body: {},
        files: {},
      ).then((response) async {
        isFirstLoadRunning = false;
        ProductModel productModel =
            ProductModel.fromJson(json.decode(response));

        final List<ProductItem> fetchedPosts = productModel.productItems ?? [];
        if (fetchedPosts.isNotEmpty) {
          products.addAll(fetchedPosts);
          update();
        } else {
          hasNextPage = false;
          update();
        }

        update();
        if (productModel.isSucceeded!) {
        } else {
          if (productModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(productModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });

      isLoadMoreRunning = false;
      update();
    }
  }

  late ScrollController scrollController;
  late ScrollController scrollControllerFilter;

  @override
  void onInit() {
    super.onInit();
    print("object");
    print(isFilters);
    firstLoadFilter();
    scrollControllerFilter = ScrollController()..addListener(_loadMoreFilter);
    scrollController = ScrollController()..addListener(_loadMore);

    update();
  }

  Future<void> refreshScreen() async {
    page = 1;
    limit = 10;
    internetConnection = false;
    hasNextPage = true;
    isFirstLoadRunning = false;
    isLoadMoreRunning = false;
    products = [];
    update();
    firstLoad();
    isFirst=false;
    scrollController = ScrollController()..addListener(_loadMore);
  }

  int pageFilter = 1;
  int limitFilter = 10;
  bool internetConnectionFilter = false;

  bool hasNextPageFilter = true;

  bool isFirstLoadRunningFilter = true;

  bool isLoadMoreRunningFilter = false;

  List<Trademarks> filtersFilter = [];

  Future firstLoadFilter() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.tradeMarkFilters}$pageFilter',
      body: {},
      files: {},
    ).then((response) async {
      TradeMarkModel tradeMarkModel =
          TradeMarkModel.fromJson(json.decode(response));

      if (pageFilter == 1) {
        filtersFilter = tradeMarkModel.trademarks ?? [];
        pageFilter++;
        update();
        await firstLoadFilter();
      } else {
        List<Trademarks> filtersList = tradeMarkModel.trademarks ?? [];
        if (filtersList.isNotEmpty) {
          filtersFilter.addAll(filtersList);
        } else {
          hasNextPageFilter = false;
          update();
        }
      }

      if (tradeMarkModel.isSucceeded!) {
        isFirstLoadRunningFilter = false;
        update();
      } else {
        if (tradeMarkModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(tradeMarkModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  void _loadMoreFilter() async {
    if (hasNextPageFilter == true &&
        isFirstLoadRunningFilter == false &&
        isLoadMoreRunningFilter == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunningFilter = true;
      update();
      pageFilter += 1;
      await HttpClientApp().request(
        method: 'GET',
        url: '${APIUrls.tradeMarkFilters}$pageFilter',
        body: {},
        files: {},
      ).then((response) async {
        TradeMarkModel tradeMarkModel =
            TradeMarkModel.fromJson(json.decode(response));
        isLoadMoreRunningFilter = false;
        update();
        List<Trademarks> filtersList = tradeMarkModel.trademarks ?? [];
        if (filtersList.isNotEmpty) {
          filtersFilter.addAll(filtersList);
        } else {
          hasNextPageFilter = false;
          update();
        }
        if (tradeMarkModel.isSucceeded!) {
        } else {
          if (tradeMarkModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(tradeMarkModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    }
  }

  List<Trademarks> selectedFilters = [];

  saveFilterValue(bool val, Trademarks selectedFilter) {
    if (val == true) {
      selectedFilters.add(selectedFilter);
    } else if (val == false) {
      selectedFilters.remove(selectedFilter);
    }
    update();
  }

  @override
  void dispose() {
    isFirstLoadRunning = true;
    update();
    scrollController.removeListener(_loadMore);
    super.dispose();
  }
}
