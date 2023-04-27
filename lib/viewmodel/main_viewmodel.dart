import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:Marouf/http/http_client.dart' as http;
import 'package:Marouf/models/brand_categories_model.dart';
import 'package:Marouf/models/closest_branches_model.dart';
import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/models/slider_model.dart';
import 'package:Marouf/models/user_data.dart';
import 'package:Marouf/utils/constant/notification_trigger.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/bottomnavigationscreens/deal_of_the_week_secreen.dart';
import 'package:Marouf/view/screens/bottomnavigationscreens/home_screen.dart';
import 'package:Marouf/view/screens/bottomnavigationscreens/loyalty_screen.dart';
import 'package:Marouf/view/screens/bottomnavigationscreens/new_arrived_secreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/view/screens/branch_details_screen.dart';
import 'package:Marouf/view/screens/drawerscreens/my_order_screen.dart';
import 'package:Marouf/view/screens/my_rewards_screen.dart';
import 'package:Marouf/view/screens/notification_screen.dart';
import 'package:Marouf/view/screens/order_details_screen.dart';
import 'package:Marouf/viewmodel/loyalty_viewmodel.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../main.dart';
import '../models/home_model.dart';
import '../models/un_read_notification.dart';
import '../utils/constant/assets_constant.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/constant/static_variables.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../utils/location_helper.dart';
import '../utils/navigation.dart';
import '../view/screens/bottomnavigationscreens/branches_screen.dart';
import '../view/screens/bottomnavigationscreens/offers_screen.dart';
import '../view/screens/signin_screen.dart';

ValueNotifier<bool> isFirstTime = ValueNotifier(true);

class MainViewModel extends GetxController {
  int unReadCount = 0;
  DeviceInfo deviceInfo = DeviceInfo();
  SliderModel sliderModel = SliderModel();
  List<RootCategories> brandCategories = [];
  int currentIndex = 0;
  LoyaltyViewModel? loyaltyController;
  bool isLoadingSlider = true;
  bool isLoadingCategory = true;
  Widget currentWidget = const HomeTempScreen();
  BrandCategories? selectedSubCategories;
  Map<String, dynamic> arguments;

  MainViewModel({this.arguments = const {}}) {
    if (arguments.isNotEmpty && isFirstTime.value) {
      isFirstTime.value = false;
      print('MainScreen arguments: $arguments');

      handleNotificationClick(arguments['data'], arguments['body']);
    }
  }
  handleNotificationClick(
      Map<String, dynamic> notification, String body) async {
    print('handleNotificationClick: $arguments');
    switch (int.parse(notification['trg'].toString())) {
      case NotificationTriggerType.addedPoints:
      case NotificationTriggerType.redeemedPoints:
        //rateUs dialog (bri)
        Future.delayed(const Duration(milliseconds: 400), () {
          NavigationApp.to(const LoyaltyScreen());
        });
        if (kDebugMode) {
          print('handleNotificationClick: rateUs dialog (bri)');
        }
        break;
      case NotificationTriggerType.newGift:
      case NotificationTriggerType.newOffer:
      case NotificationTriggerType.giftRedeemed:
      case NotificationTriggerType.offerRedeemed:
        //goto reward details screen
        Future.delayed(const Duration(milliseconds: 400), () {
          NavigationApp.to(const MyRewardsScreen());
        });
        if (kDebugMode) {
          print('handleNotificationClick: goto reward details screen');
        }
        break;
      case NotificationTriggerType.systemNotification:
        //goto system notification screen
        Future.delayed(const Duration(milliseconds: 400), () {
          NavigationApp.to(const NotificationScreen());
        });
        if (kDebugMode) {
          print('handleNotificationClick: goto system notification screen');
        }
        break;
      case NotificationTriggerType.orderClosed:
      case NotificationTriggerType.orderRecieved:
      case NotificationTriggerType.newOrder:
      case NotificationTriggerType.inDeliveryOrder:
      case NotificationTriggerType.inProgressOrder:
      case NotificationTriggerType.rejectOrder:
      case NotificationTriggerType.readyForPickup:
      case NotificationTriggerType.readyForDelivery:
      case NotificationTriggerType.driverArrived:
      case NotificationTriggerType.updateOrderStatus:
        //goto order details screen
        if (kDebugMode) {
          print('handleNotificationClick: goto order details screen');
        }
        Future.delayed(const Duration(milliseconds: 400), () {
          NavigationApp.to(OrderDetailsScreen(
            orderId: notification['tid'],
          ));
        });
        break;
      case NotificationTriggerType.brand:
        //goto brand details screen
        if (kDebugMode) {
          print('handleNotificationClick: goto brand details screen');
        }
        break;
      case NotificationTriggerType.category:
        //goto category details screen
        if (kDebugMode) {
          print('handleNotificationClick: goto category details screen');
        }
        break;
      case NotificationTriggerType.product:
        //goto product details screen
        if (kDebugMode) {
          print('handleNotificationClick: goto product details screen');
        }

        break;
      case NotificationTriggerType.rateOrder:
        //rate order dialog (orderId)
        if (kDebugMode) {
          print('handleNotificationClick: rate order dialog (orderId)');
        }
        break;
    }

    arguments = {};
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future getLoyalty() async {
    Get.delete<LoyaltyViewModel>();
    loyaltyController = Get.put(LoyaltyViewModel());
    await loyaltyController!.init().then((value) {
      loyaltyController!.update();
    });
    loyaltyController!.update();
  }

  Future init() async {
    deviceInfo = DeviceInfo();
    getSlider();
    getBrands();
    SharedPreferences.getInstance().then((value) {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        login();
      }
    });
  }


  Future getClosestBranches() async {
    LocationHelper.requestLocationPermission(() {
      Geolocator.getCurrentPosition().then((value) {
        LatLng currentLocation = LatLng(value.latitude, value.longitude);
        getClosestBranchesApi(
            currentLocation.latitude, currentLocation.longitude);
      });
    });
  }

  changeTab(int index) {
    currentIndex = index;
    update();
    switch (index) {
      case 0:
        // home
        Get.put(MainViewModel());
        currentWidget = const HomeTempScreen();
        update();
        break;
      case 1:
        //weekOffer
        currentWidget = const OffersScreen();
        update();
        break;
      case 2:
        //loyal
        currentWidget = const BranchesScreen();
        update();
        break;
      case 3:
        // MyOrder
        currentWidget = const MyOrderScreen();
        update();
        break;
    }
  }

  getNotificationUnRead() async {
    SharedPreferences.getInstance().then((value) async {
      await HttpClientApp()
          .request(
              method: 'GET',
              url: APIUrls.numberUnread,
              body: {},
              files: {},
              function: getNotificationUnRead)
          .then((response) async {
        UnReadNotification unReadNotification =
            UnReadNotification.fromJson(json.decode(response));
        if (unReadNotification.isSucceeded!) {
          unReadCount = unReadNotification.data!;
          update();
          log(unReadCount.toString(), name: 'unReadCount');
        }
      });
    });
  }

  getUserCode() async {
    SharedPreferences.getInstance().then((value) async {
      await HttpClientApp()
          .request(
              method: 'GET',
              url: APIUrls.getUserCode,
              body: {},
              files: {},
              function: getNotificationUnRead)
          .then((response) async {
        MainResponse mainResponse =
            MainResponse.fromJson(json.decode(response));
        if (mainResponse.isSucceeded!) {
          value.setString(
              SharedPreferencesKey.userCode, json.decode(response)['Data']);
          update();
        }
      });
    });
  }

  getClosestBranchesApi(lat, lng) async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getClosestBranches}?latitude=$lat&longitude=$lng',
      body: {},
      files: {},
    ).then((response) async {
      ClosestBranches closestBranches =
          ClosestBranches.fromJson(json.decode(response));
      if (closestBranches.isSucceeded!) {
        if (closestBranches.branches!.withinTheRangeBranches != null) {
          // getUserData();
          Get.back();
          checkInBranch(closestBranches.branches!.withinTheRangeBranches ?? []);
        } else if (closestBranches.branches!.outSideTheRangeBranch != null) {
          Get.back();
          Get.dialog(AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16)),
                        child: Image.asset(
                          AssetsConstant.logo,
                          height: Get.height * .2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('outOfBranchZone'.tr),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'pleaseVisitBranch'.tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          closestBranches
                              .branches!.outSideTheRangeBranch!.name!,
                          textAlign: TextAlign.center,
                          style: AppTheme.boldStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          NavigationApp.to(BranchDetailsScreen(
                              branch: closestBranches
                                  .branches!.outSideTheRangeBranch!.id!));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.colorPrimary,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'done'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.colorAccent,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Cancel'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
        }
      }
    });
  }

  createQrCode(body) {
    Get.dialog(AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            SizedBox(
              width: Get.height * .3,
              height: Get.height * .3,
              child: Expanded(
                child: QrImage(
                  data: '$body',
                  version: QrVersions.auto,
                  gapless: false,
                ),
              ),
            ),
          ],
        )));
  }

  getSlider() async {
    isLoadingSlider = true;
    sliderModel = SliderModel();
    update();
    SharedPreferences.getInstance().then((value) async {
      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getSliderItems,
        body: {},
        files: {},
      ).then((response) async {
        sliderModel = SliderModel.fromJson(json.decode(response));
        isLoadingSlider = false;
        update();
        if (sliderModel.isSucceeded!) {
        } else {
          if (sliderModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(sliderModel.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    });
  }

  getUserData() async {
    SharedPreferences.getInstance().then((value) async {
      await HttpClientApp().request(
        method: 'GET',
        url: APIUrls.getBarcodeUserData,
        body: {},
        files: {},
      ).then((response) async {
        Get.back();
        UserData userData = UserData.fromJson(json.decode(response));
        update();
        if (userData.isSucceeded!) {
          createQrCode(userData.data!.toJson());
        } else {
          if (userData.errors!.isNotEmpty) {
            Helper().errorSnackBar(userData.errors![0].errorMessage!);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      });
    });
  }

  getBrands() async {
    isLoadingCategory = true;
    brandCategories = [];
    update();
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getBrand,
      body: {},
      files: {},
    ).then((response) async {
      log(response);
      BrandCategories brandCategoriesModel =
          BrandCategories.fromJson(json.decode(response));
      isLoadingCategory = false;
      update();
      if (brandCategoriesModel.isSucceeded!) {
        brandCategories = brandCategoriesModel.categoryModel ?? [];
        print(
            'dscsdc: ${brandCategoriesModel.categoryModel!.first.backgroundImageUrl}');
      } else {
        if (brandCategoriesModel.errors!.isNotEmpty) {
          Helper().errorSnackBar(brandCategoriesModel.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  login() async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        await http.HttpClientApp().login(() {
          getUserCode();
          getNotificationUnRead();
          getLoyalty().then((value) {
            update();
            deviceInfo.getDeviceInfo().then((value) {
            });
            loyaltyController!.update();
          });
        });
      }
    });
  }

  loginCart(Function function) async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        String? phone = value.getString(SharedPreferencesKey.mobileNumber);
        function();
      } else {
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

  getSubCategory() async {
    update();
    print('${APIUrls.getSubCategory}?parentCategoryId=144&pageNumber=1');
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getSubCategory}?parentCategoryId=144&pageNumber=1',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      selectedSubCategories = BrandCategories.fromJson(json.decode(response));
      update();
      if (selectedSubCategories!.isSucceeded!) {
      } else {
        if (selectedSubCategories!.errors!.isNotEmpty) {
          Helper()
              .errorSnackBar(selectedSubCategories!.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      update();
    });
  }

  checkInBranch(List<ClosestBranch> branches) async {
    ClosestBranch? closestBranch;
    if (branches.length > 1) {
      Get.dialog(AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                      child: Image.asset(
                        AssetsConstant.logo,
                        height: Get.height * .2,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('chooseFromBranches'.tr),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<ClosestBranch>(
                          isExpanded: true,
                          value: closestBranch,
                          hint: Text('chooseFromBranches'.tr),
                          items: branches.map((ClosestBranch value) {
                            return DropdownMenuItem<ClosestBranch>(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                          onChanged: (_) {
                            closestBranch = _;
                            update();
                            setState(() {});
                          },
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        if (closestBranch != null) {
                          Helper().loading();
                          await HttpClientApp().request(
                              method: 'POST',
                              url:
                                  '${APIUrls.checkInBranch}${closestBranch?.id}',
                              body: {},
                              files: {}).then((response) async {
                            Get.back();
                            Get.back();
                            Get.back();
                            successCheckInBranch(
                                "${'checkInSuccess'.tr} ${closestBranch?.name}");
                          });
                        } else {
                          Helper().errorSnackBar('chooseFromBranches'.tr);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0, left: 8, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.colorPrimary,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'checkIn'.tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ));
    } else {
      Helper().loading();
      await HttpClientApp().request(
          method: 'POST',
          url: '${APIUrls.checkInBranch}${branches.first.id!}',
          body: {},
          files: {}).then((response) async {
        Get.back();
        Get.back();
        Get.back();
        successCheckInBranch("${'checkInSuccess'.tr} ${branches.first.name}");
      });
    }
  }

  successCheckInBranch(String message) {
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    child: Image.asset(
                      AssetsConstant.logo,
                      height: Get.height * .2,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 8, right: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.colorPrimary,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'done'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    ));
  }
}
