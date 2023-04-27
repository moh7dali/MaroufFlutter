import 'dart:convert';

import 'package:Marouf/models/branch_details.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../utils/helper.dart';

class BranchDetailsViewModel extends GetxController{

  final int branchId;
  BranchDetailsViewModel(this.branchId);

  bool isLoading=true;
late BranchDetails branchDetail;

  @override
  void onInit() {
    getBranchDetails();
  }

  getBranchDetails() async {
      await HttpClientApp().request(
        method: 'GET',
        url: '${APIUrls.getBranchDetails}?branchId=$branchId',
        body: {},
        files: {},
      ).then((response) async {
         branchDetail = BranchDetails.fromJson(json.decode(response));
         isLoading=false;
         update();
        if (branchDetail.isSucceeded!) {
        } else {
          if (branchDetail.errors!.isNotEmpty) {
            Helper().errorSnackBar(branchDetail.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
  }


}