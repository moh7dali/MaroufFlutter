import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/offer_group_viewmodel.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/no_items_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_loading_widget.dart';

class OffersGroups extends StatelessWidget {
  const OffersGroups(
      {Key? key, required this.classificationId, required this.categoryName})
      : super(key: key);
  final int classificationId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<OfferGroupViewModel>(
        init: OfferGroupViewModel(classificationId),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              actions: const [
                ActionsAppBarWidget(
                  isHome: true,
                )
              ],
              iconTheme: const IconThemeData(color: AppTheme.colorPrimaryDark),
              title: Text(categoryName,
                  style: AppTheme.boldStyle(
                      color: AppTheme.colorPrimaryDark, size: 16.sp)),
            ),
            body: controller.isFirstLoadRunning
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
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: (itemWidth / (itemHeight * .8))),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: controller.products.length + 1,
                        itemBuilder: (_, index) => index ==
                                controller.products.length
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
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox())
                            : ProductCardWidget(controller.products[index]))));
  }
}
