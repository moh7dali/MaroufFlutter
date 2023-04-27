import 'package:Marouf/main.dart';
import 'package:Marouf/models/cart_model.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/cart_screen.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/cart_viewmodel.dart';
import '../../viewmodel/main_viewmodel.dart';
import '../screens/main_screen.dart';

class ActionsAppBarWidget extends StatelessWidget {
  const ActionsAppBarWidget(
      {Key? key,
      this.isCArt = false,
      this.isHome = false,
      this.isSearch = false,
      this.buttonTag = 'cart'})
      : super(key: key);
  final bool isCArt;
  final bool isHome;
  final bool isSearch;
  final String buttonTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewModel>(
        init: MainViewModel(),
        builder: (controller) {
          return Row(
            children: [
              if (!isHome && !isSearch)
                GestureDetector(
                  onTap: () {
                    Get.offAll(
                      MainScreen(),
                      transition: Transition.fadeIn,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      AssetsConstant.homeTabIcon,
                      color: isHome
                          ? AppTheme.colorPrimary
                          : isSearch? Colors.white:AppTheme.colorPrimary,
                    ),
                  ),
                ),
              if (!isCArt)
                GestureDetector(
                  onTap: () {
                    controller.loginCart(() {
                      Get.delete<CartViewModel>();
                      NavigationApp.to(CartScreen());
                    });
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          AssetsConstant.cart,
                          color: isHome
                              ? AppTheme.colorPrimary
                              : isSearch? Colors.white:AppTheme.colorPrimary,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: ValueListenableBuilder<List<CartItem>>(
                          valueListenable: cartList,
                          builder: (BuildContext context, List<CartItem> value,
                              Widget? child) {
                            int numberOfItems = 0;
                            value.forEach((element) {
                              numberOfItems = (numberOfItems +
                                  int.parse(element.itemQuantity.toString()));
                            });
                            return value.isEmpty
                                ? Container()
                                : Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '$numberOfItems',
                                    style: AppTheme.boldStyle(
                                        color: Colors.white, size: 14),
                                  ),
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
            ],
          );
        });
  }
}
