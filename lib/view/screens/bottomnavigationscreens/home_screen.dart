import 'dart:ui';

import 'package:Marouf/view/screens/filter_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Marouf/models/slider_model.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/bottomnavigationscreens/loyalty_screen.dart';
import 'package:Marouf/view/screens/category_produuct_new_screen.dart';
import 'package:Marouf/view/widgets/slider_with_indecator.dart';
import 'package:Marouf/viewmodel/main_viewmodel.dart';

import '../../../main.dart';
import '../../../models/home_model.dart';
import '../../../utils/constant/assets_constant.dart';
import '../categry_products_screen.dart';
import '../search_screen.dart';

class HomeTempScreen extends StatelessWidget {
  const HomeTempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<MainViewModel>(
        init: MainViewModel(),
        builder: (mainController) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: mainController.init,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Card(
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(10.0)),
                              //     shadowColor: Colors.black,
                              //     child: TextField(
                              //       readOnly: true,
                              //       onTap: () => Get.to(SearchScreen()),
                              //       decoration: InputDecoration(
                              //         hintText: "search".tr,
                              //         hintStyle: AppTheme.lightStyle(
                              //             color: Colors.grey, size: 18.sp),
                              //         prefixIcon: Padding(
                              //           padding: const EdgeInsets.all(10),
                              //           child: Image.asset(
                              //             AssetsConstant.search,
                              //             width: Get.width * .015,
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //         suffixIcon: Padding(
                              //           padding: const EdgeInsets.all(10),
                              //           child: GestureDetector(
                              //             onTap: () => Get.to(FilterScreen()),
                              //             child: Image.asset(
                              //               AssetsConstant.filterIcon,
                              //               width: Get.width * .018,
                              //               color: AppTheme.colorAccent,
                              //             ),
                              //           ),
                              //         ),
                              //         border: InputBorder.none,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              mainController.isLoadingCategory
                                  ? GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: (itemWidth / (itemHeight * .5))),
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    AssetsConstant.loading,
                                                    height: Get.width * .5,
                                                    width: Get.width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  : mainController.brandCategories.isNotEmpty
                                  ? GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: (itemWidth / (itemHeight * .5))),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      buildRowHome(
                                          mainController
                                              .brandCategories[index],
                                          mainController),
                                  itemCount: mainController
                                      .brandCategories.length)
                                  : Container(),
                              SizedBox(
                                height: 8
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildRowHome(
          RootCategories categoryModel, MainViewModel mainController) =>
      SizedBox(
        height: Get.width * .44,
        child: GestureDetector(
          onTap: () {
            if (categoriesStack.value.isEmpty) {
              categoriesStack.value.add(categoryModel);
              brandsCategoriesStack.value.add(mainController.brandCategories);
            } else {
              categoriesStack.value = [categoryModel];
              brandsCategoriesStack.value = [mainController.brandCategories];
            }

            NavigationApp.to(
              CategoryProductsScreen(
                  tag: 'subCategory#${categoryModel.id}',
                  brandCategories: mainController.brandCategories,
                  selectedCategory: categoryModel),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CachedNetworkImage(
                      imageUrl: categoryModel.backgroundImageUrl ?? '',
                      placeholder: (context, url) => Image.asset(
                        AssetsConstant.loading,
                        fit: BoxFit.cover,
                        width: Get.width,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AssetsConstant.placeHolder,
                        fit: BoxFit.cover,
                        width: Get.width,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned(
                  //     top: Get.height*.175,
                  //     left: 0,
                  //     right: 0,
                  //     bottom: 0,
                  //     child: Container(
                  //       width: Get.width,
                  //   height: Get.height*.1,
                  //   decoration: BoxDecoration(color: AppTheme.colorAccent.withOpacity(.4),borderRadius: BorderRadius.circular(10)),
                  //   child: Text('${categoryModel.name}',style: AppTheme.lightStyle(color: Colors.white),),alignment: Alignment.center,))
                ],
              ),
            ),
          ),
        ),
      );
}
