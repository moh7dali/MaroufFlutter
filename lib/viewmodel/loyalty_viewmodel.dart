import 'dart:convert';
import 'dart:io';

import 'package:Marouf/models/balance_history.dart';
import 'package:Marouf/models/user_loyalty_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/constant/static_variables.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../utils/navigation.dart';
import '../view/screens/signin_screen.dart';

class LoyaltyViewModel extends GetxController{
  DeviceInfo deviceInfo = DeviceInfo();

  PagingController<int, UserBalanceHistoryModel> pagingController =
  PagingController(
    firstPageKey: 1,
  );
  static const _pageSize = 10;
  bool isLoading = true;
  late BalanceHistory branchModel;

  bool isLoadingHistory=true;
  late UserLoyalty userLoyalty;
  bool isLogin=true;


  @override
  void onInit() async{

    await deviceInfo.getDeviceInfo();
    login(()async{
     await init();
    });
  }

  Future init()async{

    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        isLogin=true;
        update();
        pagingController =
            PagingController(
              firstPageKey: 1,
            );

        pagingController.addPageRequestListener((pageKey) {
          _fetchPage(pageKey);
        });
        getUserLoyalty();
      }
      else{
        isLogin=false;
        update();
        Helper().actionDialog(
          'notRegisterUser'.tr,
          'pleaseRegister'.tr,
          confirm: () {
            NavigationApp.offUntil(SigninScreen());
          },
          cancel: () {
            Get.back();
          },
          confirmText: 'register'.tr,
        );
      }
    });
  }

  getUserLoyalty() async {
    isLoading = true;
    update();
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getUserLoyalty,
      body: {},
      files: {},
    ).then((response) async {
      isLoading = false;
      update();
      userLoyalty = UserLoyalty.fromJson(json.decode(response));
    });
  }

  login(Function function) async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        String? phone = value.getString(SharedPreferencesKey.mobileNumber);
        Map<String, String> body = {
          "MobileNumber": phone!,
          "DeviceId":
          '${Platform.isIOS ? deviceInfo.iosDeviceInfo!.identifierForVendor : deviceInfo.androidDeviceInfo!.id}',
          "DevicePlatform": '${Platform.isIOS ? 1 : 2}',
          "DeviceName":
          '${Platform.isIOS ? deviceInfo.iosDeviceInfo!.name : deviceInfo.androidDeviceInfo!.model}',
          "DeviceEmail": "DeviceEmail",
          "Language": '${appLanguage == 'ar' ? 1 : 1}',
          "NotificationToken": "sample string 6",
          "CountryId": '$countryId'
        };
        print('hfjdksl');

        await HttpClientApp()
            .login((){
          function();
          isLogin=true;
          update();});


      } else {
        isLogin=false;
        update();
      }
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
        final isLastPage = (branchModel.userBalanceHistoryModel??[]).length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage((branchModel.userBalanceHistoryModel??[]));
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage((branchModel.userBalanceHistoryModel??[]), nextPageKey);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future getBrands(int pageNumber) async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getUserBalanceHistory}?pageNumber=$pageNumber',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      branchModel = BalanceHistory.fromJson(json.decode(response));
      isLoadingHistory = false;
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