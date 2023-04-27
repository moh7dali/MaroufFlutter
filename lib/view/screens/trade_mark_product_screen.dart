import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/trade_mark_viewmodel.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_loading_widget.dart';

class TradeMarkProductsScreen extends StatelessWidget {
  const TradeMarkProductsScreen({
    Key? key,
    required this.tradeMarkId,
    required this.tradeMarkName,
    required this.buttonTag,
  }) : super(key: key);
  final int tradeMarkId;
  final String tradeMarkName;
  final String buttonTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GetBuilder<TradeMarkViewModel>(
        init: TradeMarkViewModel(tradeMarkId, tradeMarkName),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.colorAccent,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(tradeMarkName,
                    style: AppTheme.lightStyle(color: Colors.white, size: 22)),
                centerTitle: true,
                actions: [
                  ActionsAppBarWidget(
                    buttonTag: 'trade',
                  )
                ],
              ),
              body: controller.isFirstLoadRunning
                  ? const ProductCardLoadingWidget(
                      count: 5,
                    )
                  : RefreshIndicator(
                      onRefresh: controller.refreshScreen,
                      child: Column(
                        children: [
                          Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: .8,
                                          mainAxisSpacing: 0,
                                          childAspectRatio:
                                              (itemWidth / (itemHeight * .6))),
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
                                                    BorderRadius.circular(10),
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
                                      : ProductCardWidget(
                                          controller.products[index]))),
                        ],
                      ),
                    ));
        });
  }
}
