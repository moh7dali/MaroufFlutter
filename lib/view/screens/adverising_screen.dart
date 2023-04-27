import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/models/adverising_model.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:Marouf/view/screens/product_screen.dart';
import 'package:Marouf/view/screens/signin_screen.dart';
import 'package:Marouf/view/widgets/border_progress_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http/api_urls.dart';
import '../../http/http_client.dart';
import '../../main.dart';
import '../../models/adverising_model.dart';
import '../../models/all_data_model.dart';
import '../../models/cart_model.dart';
import '../../models/home_model.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import 'categry_products_screen.dart';
import 'complete_profile_screen.dart';

class AdvertisingScreen extends StatefulWidget {
  const AdvertisingScreen({Key? key, required this.advertisingModel})
      : super(key: key);
  final AdvertisingModel advertisingModel;

  @override
  State<AdvertisingScreen> createState() => _AdvertisingScreenState();
}

class _AdvertisingScreenState extends State<AdvertisingScreen> {
  final GlobalKey _progressButtonKey = GlobalKey();

  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _start();
    });
  }

  int _count = 3;

  _start() {
    ProgressBorderButtonState progressBorderButtonState =
        _progressButtonKey.currentState as ProgressBorderButtonState;
    progressBorderButtonState.start();
  }

  getSelectedCategoryDetails(productModuleType, productModuleId) async {
    Helper().loading();
    await HttpClientApp().request(
      method: 'GET',
      url:
          '${APIUrls.getSingleCategory}?productModuleType=$productModuleType&productModuleId=$productModuleId',
      body: {},
      files: {},
    ).then((response) async {
      Get.back();
      AllDataModel _brandCategories =
          AllDataModel.fromJson(json.decode(response));
      if (_brandCategories.isSucceeded!) {
        if (productModuleType == 23) {
          List<RootCategories> brandCategories = [
            RootCategories(
              id: _brandCategories.categoryModel!.id,
            )
          ];
          bool? hasSubCategories =
              _brandCategories.categoryModel!.hasSubCategory;
          Get.offAll(MainScreen());
          NavigationApp.to(
            CategoryProductsScreen(
                tag: 'subCategory#${_brandCategories.categoryModel!.id}',
                hasSubCategories: hasSubCategories,
                brandCategories: brandCategories,
                productModuleId: _brandCategories.categoryModel!.id,
                productModuleType: 23,
                selectedCategory: RootCategories(
                  id: _brandCategories.categoryModel!.id,
                )),
          );
        } else if (productModuleType == 24) {
          Get.offAll(MainScreen());
          Get.bottomSheet(
              FractionallySizedBox(
                  heightFactor: .956,
                  child: ProductScreen(_brandCategories.productItemModel!.id!)),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              barrierColor: AppTheme.colorAccent);
        } else {
          skip();
        }
      } else {
        if (_brandCategories.errors!.isNotEmpty) {
          Helper().errorSnackBar(_brandCategories.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  skip() {
    SharedPreferences.getInstance().then((value) {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        cartList.value = cartFromJson(
            "${value.getStringList(SharedPreferencesKey.cart) ?? []}");
        if (value.getBool(SharedPreferencesKey.isComplete) ?? false) {
          if (value.getBool(SharedPreferencesKey.hasReferral) ?? false) {
            Get.offAll(MainScreen(),
                duration: const Duration(seconds: 1),
                transition: Transition.fadeIn);
          } else {
            // goto Referral screen
            Get.offAll(MainScreen(),
                duration: const Duration(seconds: 1),
                transition: Transition.fadeIn);
          }
        } else {
          //goto Complete profile
          Get.offAll( CompleteProfileScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(seconds: 1));
        }
      } else {
        Get.offAll(SigninScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                AssetsConstant.signupBack,
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.width * .11,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .05),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: AppTheme.colorAccent,
                                          width: 2)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.advertisingModel.data!
                                              .images!.first.imageUrl ??
                                          '',
                                      placeholder: (w, e) => Image.asset(
                                        AssetsConstant.loading,
                                        fit: BoxFit.fitWidth,
                                        width: Get.width,
                                      ),
                                      errorWidget: (c, e, s) => Image.asset(
                                        AssetsConstant.placeHolder,
                                        fit: BoxFit.fitWidth,
                                        width: Get.width,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: widget.advertisingModel.data!.categoryId !=
                                        null ||
                                    widget.advertisingModel.data!.productId !=
                                        null
                                ? GestureDetector(
                                    onTap: () {
                                      int productModuleId = 0;
                                      int productModuleType = 0;
                                      if (widget.advertisingModel.data!
                                              .productId !=
                                          null) {
                                        productModuleType = 24;
                                        productModuleId = widget
                                            .advertisingModel.data!.productId!;
                                      } else if (widget.advertisingModel.data!
                                                  .categoryId !=
                                              null &&
                                          widget.advertisingModel.data!
                                                  .productId ==
                                              null) {
                                        productModuleType = 23;
                                        productModuleId = widget
                                            .advertisingModel.data!.categoryId!;
                                      }
                                      getSelectedCategoryDetails(
                                          productModuleType, productModuleId);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.colorPrimary,
                                          borderRadius:
                                              BorderRadius.circular(1000)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 12),
                                          child: Material(
                                            color: AppTheme.colorPrimary,
                                            child: Text(
                                              'browse'.tr,
                                              style: AppTheme.lightStyle(
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                          SizedBox(
                            width: Get.width * .11,
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                skip();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10000),
                                child: Container(
                                  color: AppTheme.colorAccent,
                                  child: ProgressBorderButton(
                                    size: Size(200, Get.height * .06),
                                    duration: 5,
                                    key: _progressButtonKey,
                                    hasRadius: true,
                                    borderColor: AppTheme.colorPrimary,
                                    onTimeEnd: () {
                                      skip();
                                    },
                                    childBuild: (context, value) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Center(
                                          child: Text(
                                            '${'skip'.tr} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.width * .04,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
