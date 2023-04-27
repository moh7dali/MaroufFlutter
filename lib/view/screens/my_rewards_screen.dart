import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/models/my_reward_model.dart';
import 'package:Marouf/viewmodel/my_rewards_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../widgets/no_items_widget.dart';
import 'main_screen.dart';

class MyRewardsScreen extends StatelessWidget {
  const MyRewardsScreen({Key? key, this.fromNotification = false})
      : super(key: key);
  final bool fromNotification;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRewardsViewModel>(
        init: MyRewardsViewModel(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (!fromNotification) {
                Get.deleteAll();
                Get.offAll(MainScreen());
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: AppTheme.colorPrimaryDark),
                title: Text('myRewards'.tr,
                    style: const TextStyle(color: AppTheme.colorPrimaryDark)),
              ),
              body: controller.isLoading
                  ? NotificationLoading()
                  : (controller.rewardModel.rewardModel ?? []).isEmpty
                      ? NoItemsWidget(
                          img: AssetsConstant.noReward,
                          title: 'noRewards'.tr,
                          hasColor: false,
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) => rewardCard(
                              controller.rewardModel.rewardModel![index],
                              controller),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 20.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          itemCount: controller.rewardModel.rewardModel!.length,
                        ),
            ),
          );
        });
  }

  Widget rewardCard(RewardModel reward, MyRewardsViewModel controller) => Card(
        child: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: Get.width,
                    height: 150.h,
                    fit: BoxFit.fitHeight,
                    imageUrl: reward.imageUrl ?? "",
                    placeholder: (w, e) => Image.asset(
                      AssetsConstant.loading,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (c, e, s) =>
                        Image.asset(AssetsConstant.longPlaceHolder),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    textDirection: isRTL('${reward.title}')
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${reward.title}',
                        textDirection: isRTL('${reward.title}')
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: AppTheme.lightStyle(
                            color: Colors.black, size: 16.sp),
                      ),
                      if (reward.hasTaken!)
                        Text(
                          ' [${'redeemed'.tr}]',
                          textDirection: isRTL('${reward.title}')
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: AppTheme.lightStyle(
                              color: Colors.black, size: 12.sp),
                        ),
                      if (reward.isExpired!)
                        Text(
                          ' [${'expired'.tr}]',
                          textDirection: isRTL('${reward.title}')
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: AppTheme.lightStyle(
                              color: AppTheme.colorAccent, size: 13.sp),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${reward.description}',
                          textDirection: isRTL('${reward.description}')
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (reward.expiryDate != null)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${'validUntil'.tr}: ${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(reward.expiryDate!))}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                ]),
          ),
        ),
      );

  Widget NotificationLoading() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsConstant.loading),
                              fit: BoxFit.cover)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Container(
                                  width: Get.width * .6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AssetsConstant.loading),
                                          fit: BoxFit.cover)),
                                  height: Get.height * .03,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4),
                                child: Container(
                                  width: Get.width * .8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AssetsConstant.loading),
                                          fit: BoxFit.cover)),
                                  height: Get.height * .06,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Container(
                                  width: Get.width * .6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AssetsConstant.loading),
                                          fit: BoxFit.cover)),
                                  height: Get.height * .03,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]);

  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
