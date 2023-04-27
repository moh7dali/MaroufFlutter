import 'package:Marouf/view/widgets/category_loading_widget.dart';
import 'package:Marouf/viewmodel/redemption_rewards_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/helper.dart';
import '../../utils/theme/app_theme.dart';

class RedemptionRewardsScreen extends StatelessWidget {
  const RedemptionRewardsScreen(this.myPoints, {Key? key}) : super(key: key);
  final int myPoints;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedemptionRewardsViewModel>(
        init: RedemptionRewardsViewModel(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text('rewardsGallery'.tr,
                  style: AppTheme.lightStyle(color: Colors.black, size: 22)),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${'myPoint'.tr}  ($myPoints)",
                        style:
                            AppTheme.boldStyle(color: Colors.white, size: 18)),
                  ),
                ),
              ],
            ),
            body: controller.isLoading
                ? CategoryLoadingWidget()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: (controller.rewardsGallary.data??[]).length,
                          itemBuilder: (context, index) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * .33,
                                      height: Get.width * .33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image:DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  controller.rewardsGallary
                                                      .data![index].imageUrl!,
                                                       errorListener: () =>  AssetImage(
                                                         AssetsConstant
                                                             .longPlaceHolder,
                                                       ),
                                                ),
                                                fit: BoxFit.cover,
                                        )
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  controller.rewardsGallary
                                                      .data![index].title!,
                                                  style: AppTheme.boldStyle(
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    controller
                                                        .rewardsGallary
                                                        .data![index]
                                                        .description!,
                                                    style: AppTheme.lightStyle(
                                                        color: Colors.black,
                                                        size: 18)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Helper().actionDialog(
                                        'redeemGift'.tr,
                                        'redeemGiftConfirm'.tr,
                                        confirm: () {
                                          controller.redeemGift(controller
                                              .rewardsGallary.data![index].id!);
                                        },
                                        cancel: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: AppTheme.colorPrimary),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                                '${'redeemGift'.tr} (${controller.rewardsGallary.data![index].numberOfPoints} ${'points'.tr})',
                                                style: AppTheme.boldStyle(
                                                    color: Colors.white,
                                                    size: 18)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )));
  }
}
