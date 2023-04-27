import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/view/widgets/product_card.dart';
import 'package:Marouf/view/widgets/product_card_loading_widget.dart';

import '../../utils/constant/assets_constant.dart';
import '../../viewmodel/product_grid_viewmodel.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget(
      {Key? key, required this.categoryId, required this.categoryTag})
      : super(key: key);
  final int categoryId;
  final String categoryTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<ProductGridViewModel>(
        init: ProductGridViewModel(categoryId,
        ),
        tag: 'product#$categoryId',
        builder: (controller) => controller.isFirstLoadRunning
            ? const ProductCardLoadingWidget(
                count: 5,
              )
            : controller.products.isEmpty
                ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: NoItemsWidget(
                        hasColor: true,
                        img: AssetsConstant.noItem,
                        title: 'soon'.tr,
                        isSmall: true,
                      ),
                    ),
                  ],
                )
                : GridView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: (itemWidth / (itemHeight * .5))),
                    padding: const EdgeInsets.all(16.0),
                    itemCount: controller.products.length + 1,
                    itemBuilder: (_, index) =>
                        index == controller.products.length
                            ? (controller.isLoadMoreRunning
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            AssetsConstant.loading,
                                            height: Get.height ,
                                            width: Get.width ,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox())
                            : ProductCardWidget(controller.products[index])));
  }
}
