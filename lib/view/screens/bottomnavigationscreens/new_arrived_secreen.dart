import 'package:Marouf/view/widgets/product_card.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/view/widgets/product_card_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../viewmodel/new_arrived_viewmodel.dart';

class NewArrivedScreen extends StatelessWidget {
  const NewArrivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GetBuilder<NewArrivedViewModel>(
        init: NewArrivedViewModel(),
        builder: (controller) {
          return Column(
            children: [
              controller.isLoading
                  ? const ProductCardLoadingWidget()
                  : (controller.newProducts.productItems ?? []).isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: .8,
                                  mainAxisSpacing: 0,
                                  childAspectRatio:
                                      (itemWidth / (itemHeight * .6))),
                          itemCount:
                              controller.newProducts.productItems!.length,
                          itemBuilder: (context, index) => ProductCardWidget(
                              controller.newProducts.productItems![index]))
                      :  NoItemsWidget(
                img: AssetsConstant.noItem,
                title: 'soon'.tr,
                body: 'willBeAddedSoon'.tr,
              ),
            ],
          );
        });
  }
}
