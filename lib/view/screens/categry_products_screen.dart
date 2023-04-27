import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Marouf/models/home_model.dart';
import 'package:Marouf/viewmodel/category_products_viewmodel.dart';

import '../../main.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/category_grid_view_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_loading_widget.dart';
import '../widgets/product_grid_view_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({
    Key? key,
    required this.tag,
    this.hasSubCategories,
    required this.brandCategories,
    required this.selectedCategory,
    this.productModuleId,
    this.productModuleType,
  }) : super(key: key);

  final String tag;
  final dynamic productModuleId;
  final dynamic productModuleType;
  final List<RootCategories> brandCategories;
  final RootCategories selectedCategory;
  final bool? hasSubCategories;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductsViewModel>(
      tag: tag,
      init: CategoryProductsViewModel(brandCategories, selectedCategory,
          hasSubCategories: hasSubCategories,
          productModuleId: productModuleId,
          productModuleType: productModuleType),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (categoriesStack.value.length > 1 &&
                brandsCategoriesStack.value.length > 1) {
              categoriesStack.value.removeLast();
              brandsCategoriesStack.value.removeLast();

              Get.delete(tag: tag);
              Get.back();
              NavigationApp.to(
                CategoryProductsScreen(
                    tag: 'subCategory#${categoriesStack.value.last.id}',
                    brandCategories: brandsCategoriesStack.value.last,
                    selectedCategory: categoriesStack.value.last),
              );
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color:AppTheme.colorAccent),
              title: Text(controller.selectedCategory.name ?? '',
                  style: AppTheme.lightStyle(color: AppTheme.colorAccent, size: 22)),
              centerTitle: true,
              actions: [ ActionsAppBarWidget(
                isHome: true,
              )],
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: TabBar(
                    labelColor: AppTheme.colorAccent,
                    isScrollable: true,
                    controller: controller.tabController,
                    indicatorColor: AppTheme.colorAccent,
                    labelStyle: AppTheme.lightStyle(color: Colors.black),
                    tabs: controller.brandCategories
                        .map((RootCategories categoryModel) {
                      return Tab(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedSubCategories = [];
                            categoriesStack.value.last = categoryModel;
                            brandsCategoriesStack.value.last =
                                controller.selectedSubCategories;
                            controller.selectedCategory = categoryModel;
                            brandsCategoriesStack.value.last =
                                controller.brandCategories;
                            categoriesStack.value.last = categoryModel;
                            controller.tabController!.index = controller
                                .brandCategories
                                .indexOf(categoryModel);
                          },
                          child: Text(
                            categoryModel.name ?? '',
                            style: AppTheme.lightStyle(
                                color: AppTheme.colorAccent, size: 18),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.brandCategories
                          .map((RootCategories categoryModel) {
                        return categoryModel.hasSubCategory ?? false
                            ? CategoryGridViewWidget(
                            categoryId: categoryModel.id!, categoryTag: tag)
                            : ProductGridViewWidget(
                            categoryId: categoryModel.id!, categoryTag: tag);
                      }).toList(),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
