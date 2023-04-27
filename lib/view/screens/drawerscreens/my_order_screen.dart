import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/loding_history_widget.dart';
import 'package:Marouf/view/widgets/order_history_card_widget.dart';
import 'package:Marouf/viewmodel/my_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/navigation.dart';
import '../../widgets/no_items_widget.dart';
import '../signin_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('orderHistory'.tr,
            style: AppTheme.boldStyle(color: Colors.black, size: 20)),
      ),
      body: GetBuilder<MyOrdersViewModel>(
          init: MyOrdersViewModel(),
          builder: (controller) {
            if (!controller.isLogin) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'notRegisterUser'.tr,
                        style: AppTheme.boldStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width * .4,
                      child: InkWell(
                        onTap: () {
                          NavigationApp.offUntil(SigninScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.colorAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'register'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (controller.isFirstLoadRunning) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 11,
                itemBuilder: (_, index) => LoadingHistoryCard(),
              );
            } else {
              return controller.orders.isEmpty
                  ? NoItemsWidget(
                      img: AssetsConstant.noOrder,
                      title: 'noOrders'.tr,
                      body: '',
                    )
                  : RefreshIndicator(
                      onRefresh: controller.refreshScreen,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16.0),
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: controller.scrollController,
                              itemCount: controller.orders.length + 1,
                              itemBuilder: (_, index) =>
                                  index == controller.orders.length
                                      ? (controller.isLoadMoreRunning
                                          ? Column(
                                              children: const [
                                                LoadingHistoryCard(),
                                                LoadingHistoryCard(),
                                              ],
                                            )
                                          : const SizedBox())
                                      : OrderCardWidget(
                                          order: controller.orders[index],
                                          myOrdersViewModel: controller),
                            ),
                          ),
                        ],
                      ),
                    );
            }
          }),
    );
  }
}
