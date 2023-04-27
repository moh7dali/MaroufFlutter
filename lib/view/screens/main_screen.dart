import 'package:Marouf/view/screens/bottomnavigationscreens/loyalty_screen.dart';
import 'package:Marouf/view/screens/my_rewards_screen.dart';
import 'package:Marouf/view/widgets/actions_app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/notification_screen.dart';
import 'package:Marouf/view/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/view/widgets/bottom_navigation_bwr_widget.dart' as n;
import '../../main.dart';
import '../../models/cart_model.dart';
import '../../models/slider_model.dart';
import '../../utils/constant/shared_preferences_constant.dart';
import '../../utils/helper.dart';
import '../../viewmodel/main_viewmodel.dart';
import '../widgets/check_options_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/slider_with_indecator.dart';
import 'cart_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key
  bool isSelectedTab = true;

  @override
  Widget build(BuildContext context) {
    final arguments = Map<String, dynamic>.from(
        (ModalRoute.of(context)?.settings.arguments ?? {}) as Map);
    return GetBuilder<MainViewModel>(
        init: MainViewModel(arguments: arguments),
        builder: (mainController) {
          return Scaffold(
            key: scaffoldKey,
            // bottomNavigationBar: const n.NavigationBar(),
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    AssetsConstant.menu,
                    color: AppTheme.colorPrimary,
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: AppTheme.colorPrimary),
              backgroundColor: AppTheme.colorPrimaryDark,
              centerTitle: true,
              title: Hero(
                tag: 'logoTag',
                child: Image.asset(
                  AssetsConstant.logo,
                  height: Get.height * .07,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionsAppBarWidget(
                      isHome: true,
                    ),
                    GestureDetector(
                      onTap: () {
                        mainController.loginCart(() {
                          mainController.unReadCount = 0;
                          Get.back();
                          NavigationApp.to(NotificationScreen());
                        });
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              AssetsConstant.notifications,
                              color: AppTheme.colorPrimary,
                              width: Get.width * .08,
                            ),
                          ),
                          if (mainController.unReadCount > 0)
                            Positioned(
                              top: 0,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        mainController.unReadCount < 10
                                            ? 6
                                            : 2.0),
                                    child: Text(
                                      '${mainController.unReadCount}',
                                      style: AppTheme.boldStyle(
                                          color: Colors.white, size: 14),
                                    ),
                                  )),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            drawer: const DrawerWidget(),
            body: Stack(
              children: [
                Column(
                  children: [
                    mainController.sliderModel.data?.isNotEmpty ?? false
                        ? SliderAdsWidget(false,
                            slides: mainController.sliderModel.data!)
                        : SliderAdsWidget(true, slides: [
                            HomeSliders(),
                            HomeSliders(),
                            HomeSliders(),
                          ]),
                    Expanded(child: mainController.currentWidget),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    height: Get.height * .075,
                    width: Get.width,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: Get.height * .007,
                          top: Get.height * .007,
                          left: Get.width * .02,
                          right: Get.width * .02,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        mainController.changeTab(0);
                                      },
                                      child: Container(
                                        height: Get.height * .3,
                                        color: mainController.currentIndex == 0
                                            ? AppTheme.colorAccent
                                            : AppTheme.bottomNavColor,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * .1,
                                            ),
                                            Image.asset(
                                              AssetsConstant.homeTabIcon,
                                              height: Get.height * .038,
                                              color:
                                                  mainController.currentIndex ==
                                                          0
                                                      ? AppTheme.colorPrimary
                                                      : AppTheme.colorAccent,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'homeTab'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: mainController
                                                              .currentIndex ==
                                                          0
                                                      ? AppTheme.colorPrimary
                                                      : AppTheme.colorAccent,
                                                  size: 14.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        mainController.loginCart(() {
                                          mainController.changeTab(2);
                                        });
                                      },
                                      child: Container(
                                        height: Get.height * .3,
                                        color: mainController.currentIndex == 2
                                            ? AppTheme.colorAccent
                                            : AppTheme.bottomNavColor,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * .15,
                                            ),
                                            Image.asset(
                                                AssetsConstant.branchesTabIcon,
                                                height: Get.height * .04,
                                                color: mainController
                                                            .currentIndex ==
                                                        2
                                                    ? AppTheme.colorPrimary
                                                    : AppTheme.colorAccent),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'branches'.tr,
                                              style: AppTheme.boldStyle(
                                                  color: mainController
                                                              .currentIndex ==
                                                          2
                                                      ? AppTheme.colorPrimary
                                                      : AppTheme.colorAccent,
                                                  size: 14.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.colorWhite,
                                    border: Border.all(
                                        color: AppTheme.colorAccent)),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: SizedBox(
                                      width: Get.height * .075,
                                      height: Get.height * .075,
                                      child: GestureDetector(
                                        onTap: () {
                                          mainController.loginCart(() {
                                            Get.dialog(CheckInOptionsWidget());
                                          });
                                          // AlertDialog(
                                          //   // titlePadding: EdgeInsets.only(top: 300),
                                          //     backgroundColor: Colors.transparent,
                                          //     title:
                                          //   Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       AnimatedPadding(
                                          //         padding:EdgeInsets.only(top: 300),
                                          //         duration: Duration(seconds: 4),
                                          //         child: GestureDetector(
                                          //           onTap: () => Get.to(MyRewardsScreen()),
                                          //           child: Column(
                                          //             children: [
                                          //               Text(
                                          //                 "myRewards".tr,
                                          //                 style: AppTheme
                                          //                     .lightStyle(
                                          //                         color: Colors
                                          //                             .white),
                                          //               ),
                                          //               SizedBox(height: 20,),
                                          //               Image.asset(AssetsConstant.loyaltyIcon,height: Get.height*.1,color:  Colors.white,)
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       AnimatedPadding(
                                          //         padding:EdgeInsets.only(top: 300),
                                          //         duration: Duration(seconds: 4),
                                          //         child: GestureDetector(
                                          //           onTap: () => Get.to(LoyaltyScreen()),
                                          //           child: Column(
                                          //             children: [
                                          //               Text(
                                          //                 "myPoint".tr,
                                          //                 style: AppTheme
                                          //                     .lightStyle(
                                          //                         color: Colors
                                          //                             .white),
                                          //               ),
                                          //               SizedBox(height: 20,),
                                          //               Image.asset(AssetsConstant.myPoint,height: Get.height*.1,color: Colors.white,)
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   )
                                          // ),
                                          // barrierColor: AppTheme.colorAccent
                                          //     .withOpacity(0.8),
                                          // barrierDismissible: false);
                                          // mainController.loginCart(() {
                                          //   NavigationApp.to(CartScreen());
                                          // });
                                        },
                                        child: Image.asset(
                                          AssetsConstant.logo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: 0,
                              //   left: 0,
                              //   right: 0,
                              //   child: ValueListenableBuilder<List<CartItem>>(
                              //     valueListenable: cartList,
                              //     builder: (BuildContext context,
                              //         List<CartItem> value, Widget? child) {
                              //       int numberOfItems = 0;
                              //       value.forEach((element) {
                              //         numberOfItems = (numberOfItems +
                              //             int.parse(
                              //                 element.itemQuantity.toString()));
                              //       });
                              //       return value.isEmpty
                              //           ? Container()
                              //           : Container(
                              //         decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.red),
                              //         child: Center(
                              //           child: Text(
                              //             '$numberOfItems',
                              //             style: AppTheme.boldStyle(
                              //                 color: Colors.white,
                              //                 size: 14),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
