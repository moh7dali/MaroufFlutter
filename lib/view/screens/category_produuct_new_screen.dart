import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/actions_app_bar_widget.dart';
import 'package:Marouf/view/widgets/category_grid_view_widget.dart';
import 'package:Marouf/view/widgets/product_grid_view_widget.dart';
import 'package:Marouf/viewmodel/category_product_new_viewmodel.dart';

import '../../models/home_model.dart';

class CategoryProductNewScreen extends StatelessWidget {
    const CategoryProductNewScreen(
      {Key? key,
      required this.id,
        this.tag,
      required this.name,
      required this.hasSubCategories})
      : super(key: key);
  final int id;
  final String name;
  final String? tag;
  final bool hasSubCategories;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductNewViewModel>(
      tag: '$tag',
        init: CategoryProductNewViewModel(id, name, hasSubCategories),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                ActionsAppBarWidget(
                  isHome: true,
                )
              ],
              iconTheme: const IconThemeData(color: AppTheme.colorPrimaryDark),
              title: Text(name,
                  style: AppTheme.boldStyle(
                      color: AppTheme.colorPrimaryDark, size: 16.sp)),
            ),
            body: !controller.isLoading
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TabBar(
                          labelColor: Colors.black,
                          isScrollable: true,
                          controller: controller.tabController,
                          indicatorColor: AppTheme.colorAccent,
                          labelStyle: AppTheme.lightStyle(color: Colors.black),
                          tabs: controller.selectedSubCategories.categoryModel!
                              .map((RootCategories categoryModel) {
                            return Tab(
                              child: IgnorePointer(
                                ignoring: true,
                                child: Text(
                                  categoryModel.name ?? '',
                                  style: AppTheme.lightStyle(
                                      color: AppTheme.colorAccent, size: 16.sp),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: controller.tabController,
                        children: controller
                            .selectedSubCategories.categoryModel!
                            .map((RootCategories categoryModel) {
                          return controller.selectedCategory.hasSubCategory ??
                                  false
                              ? CategoryGridViewWidget(
                                  categoryId: categoryModel.id!,
                                  categoryTag: 'category#${categoryModel.id}')
                              : ProductGridViewWidget(
                                  categoryId: categoryModel.id!,
                                  categoryTag: 'product#${categoryModel.id}');
                        }).toList(),
                      ))
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
          );
        });
  }
}
