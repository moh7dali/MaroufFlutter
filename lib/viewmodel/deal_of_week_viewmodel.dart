import 'dart:convert';

import 'package:Marouf/models/products_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../utils/helper.dart';

class DealOfWeekViewModel extends GetxController {
  bool isLoading = true;
  ProductModel dealWeek=ProductModel();


  final PagingController<int, ProductItem> pagingController =
  PagingController(
    firstPageKey: 1,
  );
  static const _pageSize = 10;

  @override
  void onInit() {
    getDeals(1);
    // pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      getDeals(pageKey).then((value) {
        final isLastPage = dealWeek.productItems!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(dealWeek.productItems!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(dealWeek.productItems!, nextPageKey);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }


  getDeals(int page) async {
    isLoading = true;
    update();
    print('${APIUrls.dealWeek}?brandId=1&productPropertry=4&pageNumber=$page');
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.dealWeek}?brandId=1&productPropertry=4&pageNumber=$page',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      dealWeek = ProductModel.fromJson(json.decode(response));
      update();
      print(dealWeek.productItems?.length);
      isLoading=false;
      if (dealWeek.isSucceeded!) {
      } else {
        if (dealWeek.errors!.isNotEmpty) {
          Helper().errorSnackBar(dealWeek.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }

      update();
    });
  }
}
