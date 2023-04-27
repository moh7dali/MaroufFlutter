import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/models/notification_model.dart';
import 'package:Marouf/models/ordrer_details.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:Marouf/view/screens/my_rewards_screen.dart';
import 'package:Marouf/view/screens/order_details_screen.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/viewmodel/notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../utils/constant/assets_constant.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationViewModel>(
      init: NotificationViewModel(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppTheme.colorAccent),
            leading: BackButton(
              onPressed: () {
                Get.offAll(MainScreen());
              },
            ),
            title: Text(
              'notification'.tr,
              style: TextStyle(color: AppTheme.colorAccent),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    controller.readAllNotifications();
                  },
                  child: Text(
                    "readAll".tr,
                    style: AppTheme.lightStyle(color: AppTheme.colorAccent),
                  ))
            ],
          ),
          body: controller.isFirstLoadRunning
              ? NotificationLoading()
              : (controller.notificationModel.notificationList ?? []).isEmpty
              ? NoItemsWidget(
            hasColor: false,
            img: AssetsConstant.noNotifications,
            title: 'noNotification'.tr,
          )
              : RefreshIndicator(
            onRefresh: controller.refreshScreen,
            child: WillPopScope(
              onWillPop: () async {
                Get.offAll(MainScreen());
                return false;
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      controller: controller.scrollController,
                      itemCount: controller.orders.length + 1,
                      itemBuilder: (_, index) =>
                      index == controller.orders.length
                          ? (controller.isLoadMoreRunning
                          ? Column(
                        children: [
                          NotificationLoading(),
                          NotificationLoading(),
                        ],
                      )
                          : const SizedBox())
                          : notificationCard(
                          controller.notificationModel
                              .notificationList![index],
                          controller),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  // if (controller.isLoadMoreRunning) const LoadingPlayerCard(),
                ],
              ),
            ),
          )),
    );
  }

  Widget notificationCard(NotificationItemModel notification,
      NotificationViewModel controller) =>
      GestureDetector(
        onTap: () {
          controller.readNotification(notification.id!).then((value) {
            if (notification.triggerTypeId == 1 ||
                notification.triggerTypeId == 2) {
              Get.back();
            } else if (notification.triggerTypeId == 3 ||
                notification.triggerTypeId == 4 ||
                notification.triggerTypeId == 5 ||
                notification.triggerTypeId == 6) {
              NavigationApp.to(MyRewardsScreen());
            } else if (notification.triggerTypeId == 11 ||
                notification.triggerTypeId == 12 ||
                notification.triggerTypeId == 13 ||
                notification.triggerTypeId == 16) {
              NavigationApp.to(
                  OrderDetailsScreen(orderId: notification.triggerId!));
            }
          });
        },
        child: Container(
          color: notification.isReaded ?? false
              ? Colors.transparent
              : Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textDirection: isRTL('${notification.subject}')
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Expanded(
                        child: Text(
                          '${notification.subject}',
                          textDirection: isRTL('${notification.subject}')
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: AppTheme.boldStyle(
                              color: Colors.black, size: 14.sp),
                        ),
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
                          '${notification.message}',
                          textDirection: isRTL('${notification.message}')
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    textDirection: isRTL('${notification.message}')
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Text(
                        intl.DateFormat('yyyy-MM-dd hh:mm a').format(
                            DateTime.parse(notification.creationDate!)
                                .add(Duration(hours: 3))),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
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
