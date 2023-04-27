import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/view/screens/product_menu_screen.dart';
import 'package:Marouf/view/widgets/product_card_loading_widget.dart';
import 'package:Marouf/viewmodel/category_grid_viewmodel.dart';
import '../../main.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import '../screens/category_produuct_new_screen.dart';

class CategoryGridViewWidget extends StatelessWidget {
  const CategoryGridViewWidget(
      {Key? key, required this.categoryId, required this.categoryTag})
      : super(key: key);
  final int categoryId;
  final String categoryTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<CategoryGridViewModel>(
        init: CategoryGridViewModel(categoryId),
        tag: 'category#$categoryId',
        builder: (controller) => controller.isFirstLoadRunning
            ? const ProductCardLoadingWidget(
                count: 5,
              )
            : GridView.builder(
                shrinkWrap: true,
                controller: controller.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: .5,
                    mainAxisSpacing: 0,
                    childAspectRatio: (itemWidth / (itemHeight * .5))),
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.selectedSubCategories.length + 1,
                itemBuilder: (_, index) => index ==
                        controller.selectedSubCategories.length
                    ? (controller.isLoadMoreRunning
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    AssetsConstant.loading,
                                    height: Get.width * .5,
                                    width: Get.width * .5,
                                    fit: BoxFit.cover,
                                  ),

                                ],

                              ),
                            ),
                          )
                        : const SizedBox())
                    : GestureDetector(
                        onTap: () {
                          categoriesStack.value
                              .add(controller.selectedSubCategories[index]);
                          brandsCategoriesStack.value
                              .add(controller.selectedSubCategories);
                          if (controller.selectedSubCategories[index]
                                  .hasSubCategory ??
                              false) {
                            Get.delete(tag: categoryTag);
                            Get.back();
                            NavigationApp.to(CategoryProductNewScreen(
                              tag:
                                  'category#${controller.selectedSubCategories[index].id}',
                              id: controller.selectedSubCategories[index].id,
                              hasSubCategories: controller
                                  .selectedSubCategories[index].hasSubCategory!,
                              name:
                                  controller.selectedSubCategories[index].name!,
                            ));
                          } else {
                            NavigationApp.to(ProductMenuScreen(
                              categoryId:
                                  controller.selectedSubCategories[index].id,
                              categoryName:
                                  controller.selectedSubCategories[index].name!,
                            ));
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: controller
                                              .selectedSubCategories[index]
                                              .backgroundImageUrl !=
                                          null
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            controller
                                                .selectedSubCategories[index]
                                                .backgroundImageUrl!,
                                            errorListener: () =>
                                                const AssetImage(
                                              AssetsConstant.longPlaceHolder,
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : const DecorationImage(
                                          image: AssetImage(
                                            AssetsConstant.longPlaceHolder,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                  top: Get.height*.16,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height*.1,
                                    decoration: BoxDecoration(color: AppTheme.colorAccent.withOpacity(.4),borderRadius: BorderRadius.circular(10)),
                                    child: Text('${ controller
                                        .selectedSubCategories[index].name}',style: AppTheme.lightStyle(color: Colors.white),),alignment: Alignment.center,))
                            ],
                          ),
                        ),
                      )));
  }
}
