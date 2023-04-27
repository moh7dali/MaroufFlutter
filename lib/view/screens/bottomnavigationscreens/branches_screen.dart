import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/models/branche_model.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/branch_details_screen.dart';
import 'package:Marouf/view/widgets/branch_loading_widgte.dart';
import 'package:Marouf/viewmodel/branches_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../utils/constant/assets_constant.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchesViewModel>(
        init: BranchesViewModel(),
        builder: (controller) {
          return Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //     "branches".tr,
            //     style:
            //     AppTheme.lightStyle(color: AppTheme.colorAccent, size: 18),
            //   ),
            //   titleTextStyle:
            //   AppTheme.boldStyle(color: AppTheme.colorAccent, size: 18),
            // ),
            body: Column(
              children: [
                Expanded(
                  child: PagedListView<int, BranchModelElement>(
                    shrinkWrap: true,
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<
                        BranchModelElement>(
                        firstPageProgressIndicatorBuilder: (context) =>
                        const BranchLoadingWidget(),
                        newPageProgressIndicatorBuilder: (context) =>
                        const BranchLoadingWidget(),
                        itemBuilder: (context, item, index) => GestureDetector(
                          onTap: () {
                            NavigationApp.to(
                                BranchDetailsScreen(branch: item.id!));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      width: Get.width,
                                      height: Get.height * .25,
                                      fit: BoxFit.cover,
                                      imageUrl: item.imageUrl ?? "",
                                      placeholder: (w, e) => Image.asset(
                                        AssetsConstant.loading,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (c, e, s) => Image.asset(
                                          AssetsConstant.longPlaceHolder),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Text(item.name!,
                                            style: AppTheme.boldStyle(
                                                color:
                                                AppTheme.colorPrimary,
                                                size: 16.sp)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
          );
        });
  }
}
