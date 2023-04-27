import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/TradeMarkModel.dart';
import '../utils/helper.dart';

class FilterViewModel extends GetxController{
  int pageFilter = 1;
  int limitFilter = 10;
  bool internetConnectionFilter = false;

  bool hasNextPageFilter = true;

  bool isFirstLoadRunningFilter = true;

  bool isLoadMoreRunningFilter = false;

  late ScrollController scrollControllerFilter;

  List<Trademarks> filtersFilter = [];

  @override
  void onInit() {
    super.onInit();
    firstLoadFilter();
    scrollControllerFilter = ScrollController()..addListener(_loadMoreFilter);
  }

  Future firstLoadFilter() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.tradeMarkFilters}$pageFilter',
      body: {},
      files: {},
    ).then((response) async {
      TradeMarkModel tradeMarkModel = TradeMarkModel.fromJson(json.decode(response));


      if (pageFilter==1) {
        filtersFilter = tradeMarkModel.trademarks??[];
        pageFilter++;
        update();
      await firstLoadFilter();
      }else{
        List<Trademarks> filtersList = tradeMarkModel.trademarks?? [];
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
        scrollControllerFilter.position.extentAfter < 300) {
      isLoadMoreRunningFilter = true;
      update();
      pageFilter += 1;
      await HttpClientApp().request(
        method: 'GET',
        url:  '${APIUrls.tradeMarkFilters}$pageFilter',
        body: {},
        files: {},
      ).then((response) async {
        TradeMarkModel tradeMarkModel =
        TradeMarkModel.fromJson(json.decode(response));
        isLoadMoreRunningFilter = false;
        update();
        List<Trademarks> filtersList = tradeMarkModel.trademarks?? [];
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

  // Future<void> refreshScreen() async {
  //   pageFilter = 1;
  //   limitFilter = 10;
  //   internetConnectionFilter = false;
  //   hasNextPageFilter = true;
  //   isFirstLoadRunningFilter = false;
  //   isLoadMoreRunningFilter = false;
  //   filtersFilter = [];
  //   update();
  //   firstLoad();
  //   scrollControllerFilter= ScrollController()..addListener(_loadMore);
  // }

  List<Trademarks> selectedFilters = [];
  saveFilterValue(bool val,Trademarks selectedFilter){
    if(val==true){
      selectedFilters.add(selectedFilter);
    }
    else if(val==false){
      selectedFilters.remove(selectedFilter);
    }
    update();
  }

  @override
  void dispose() {
    isFirstLoadRunningFilter = true;
    scrollControllerFilter.removeListener(_loadMoreFilter);
    super.dispose();
  }
}