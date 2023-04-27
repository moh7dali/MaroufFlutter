import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/filter_screen.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/view/widgets/product_card_loading_widget.dart';
import 'package:Marouf/viewmodel/search_products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/TradeMarkModel.dart';
import '../../utils/constant/assets_constant.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<SearchOrderViewModel>(
        init: SearchOrderViewModel(isFilters: false),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: AppTheme.colorAccent,
                centerTitle: true,
                title: TextFormField(
                  style: AppTheme.lightStyle(color: Colors.white),
                  controller: controller.searchKeyController,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.refreshScreen();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'search'.tr,
                    hintStyle: AppTheme.lightStyle(color: Colors.white),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => controller.refreshScreen(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        AssetsConstant.search,
                        color: Colors.white,
                        width: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => Get.to(FilterScreen()),
                      child: Image.asset(
                        AssetsConstant.filterIcon,
                        color: Colors.white,
                        width: 30,
                      ),
                    ),
                  ),
                  ActionsAppBarWidget(
                    isSearch: true,
                  )
                ],
              ),
              body: controller.isFirstLoadRunning
                  ? const ProductCardLoadingWidget(
                      count: 5,
                    )
                  : RefreshIndicator(
                      onRefresh: controller.refreshScreen,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          controller.selectedFilters.isEmpty
                              ? SizedBox()
                              : SizedBox(
                                  height: Get.height * .06,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.selectedFilters.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.width * .3,
                                        height: Get.height * .04,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: AppTheme.colorAccent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                  controller
                                                      .selectedFilters[index]
                                                      .name!,
                                                  style: AppTheme.lightStyle(
                                                      color: Colors.white)),
                                            ),
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .selectedFilters
                                                          .remove(controller
                                                                  .selectedFilters[
                                                              index]);
                                                      controller
                                                          .refreshScreen();
                                                      controller.update();
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          (controller.products.isEmpty ||
                                      controller.products == null) &&
                                  controller.isFirst
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(height: Get.height * .3),
                                    NoItemsWidget(
                                        img: AssetsConstant.search,
                                        title: '',
                                        body: 'noSearch'.tr,
                                        isSmall: true),
                                  ],
                                )
                              : Expanded(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: .8,
                                              mainAxisSpacing: 0,
                                              childAspectRatio: (itemWidth /
                                                  (itemHeight * .6))),
                                      padding: const EdgeInsets.all(16.0),
                                      controller: controller.scrollController,
                                      itemCount: controller.products.length + 1,
                                      itemBuilder: (_, index) => index ==
                                              controller.products.length
                                          ? (controller.isLoadMoreRunning
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Stack(
                                                      children: [
                                                        Image.asset(
                                                          AssetsConstant
                                                              .loading,
                                                          height:
                                                              Get.width * .5,
                                                          width: Get.width * .5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox())
                                          : ProductCardWidget(
                                              controller.products[index]))),
                        ],
                      ),
                    ));
        });
  }
}
