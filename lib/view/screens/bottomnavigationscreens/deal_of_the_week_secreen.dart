import 'package:Marouf/view/widgets/product_card.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/view/widgets/product_card_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../viewmodel/deal_of_week_viewmodel.dart';

class DealOfTheWeekScreen extends StatelessWidget {
  const DealOfTheWeekScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GetBuilder<DealOfWeekViewModel>(
        init: DealOfWeekViewModel(),
        builder: (controller) {
          return Stack(
            children: [
              controller.isLoading
                  ?const ProductCardLoadingWidget()
                  : controller.dealWeek.productItems !=null
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: .8,
                                  mainAxisSpacing: 0,
                                  childAspectRatio:
                                      (itemWidth / (itemHeight * .6))),
                          itemCount: controller.dealWeek.productItems!.length,
                          itemBuilder: (context, index) => ProductCardWidget(
                              controller.dealWeek.productItems![index]))
                      :  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: NoItemsWidget(
                img: AssetsConstant.noItem,
                title: 'soon'.tr,
                isSmall: true,
              ),
                          ),
                        ],
                      ),
            ],
          );
        });
  }
}
