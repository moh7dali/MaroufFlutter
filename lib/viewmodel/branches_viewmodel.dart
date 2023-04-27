import 'dart:convert';

import 'package:Marouf/http/api_urls.dart';
import 'package:Marouf/http/http_client.dart';
import 'package:Marouf/models/branche_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../utils/helper.dart';

class BranchesViewModel extends GetxController {
  final PagingController<int, BranchModelElement> pagingController =
  PagingController(
    firstPageKey: 1,
  );
  static const _pageSize = 10;
  bool isLoading = true;
  late BranchModel branchModel;
  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      getBrands(pageKey).then((value) {
        final isLastPage = branchModel.branchModel!.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(branchModel.branchModel!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(branchModel.branchModel!, nextPageKey);
        }
      });

    } catch (error) {
      pagingController.error = error;
    }
  }

  Future getBrands(int pageNumber) async {
    print('${APIUrls.getBranches}?merchantId=1&pageNumber=$pageNumber');
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getBranches}?merchantId=1&pageNumber=$pageNumber',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      branchModel = BranchModel.fromJson(json.decode(response));
      isLoading = false;
      update();
      if (branchModel.isSucceeded!) {
      } else {
        if (branchModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(branchModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }
}
