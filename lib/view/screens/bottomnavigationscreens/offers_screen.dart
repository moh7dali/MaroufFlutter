import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/view/screens/offers_group_screen.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/viewmodel/offers_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../../widgets/product_grid_view_widget.dart';
import '../product_menu_screen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersViewModel>(
      init: OffersViewModel(),
      builder: (controller) => Scaffold(
        body: ListView(shrinkWrap: true, children: [
          controller.isLoad
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                        height: 40.h,
                        child: Image.asset(
                          AssetsConstant.loading,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            height: 150.h,
                            child: Image.asset(
                              AssetsConstant.loading,
                              fit: BoxFit.fitWidth,
                            )),
                      ),
                  itemCount: 5)
              : controller.classificationsProduct == null
                  ? SizedBox(
                      child: NoItemsWidget(
                      img: AssetsConstant.noItem,
                      title: 'soon'.tr,
                      isSmall: true,
                    ))
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index !=
                            controller.classificationsProduct!.length) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppTheme.colorAccent.withOpacity(.8),
                                  AppTheme.colorPrimary
                                ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.classificationsProduct![index].name}",
                                      style: AppTheme.boldStyle(
                                          color: Colors.white, size: 18.sp),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(OffersGroups(classificationId: controller.classificationsProduct![index].id!, categoryName: controller.classificationsProduct![index].name!));
                                      },
                                      child: Text(
                                        "seeMore".tr,
                                        style: AppTheme.boldStyle(
                                            color: Colors.white, size: 18.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Get.height * .3,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .classificationsProduct![index]
                                  .productItems!
                                  .length,
                              itemBuilder: (context, index1) {
                                return ProductCardWidget(controller
                                    .classificationsProduct![index]
                                    .productItems![index1]);
                              }),
                        );
                      },
                      itemCount: controller.classificationsProduct!.length + 1),
        ]),
      ),
    );
  }
}
