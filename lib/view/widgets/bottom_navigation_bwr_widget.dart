import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/animated_bottom_bar_widget.dart';
import 'package:Marouf/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewModel>(builder: (value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
              // gradient: LinearGradient(colors: [
              //   AppTheme.colorAccent.withOpacity(.8),
              //   AppTheme.colorPrimary
              // ]),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimationButtonBar(
                  function: () {
                    value.changeTab(0);
                  },
                  check: value.currentIndex == 0,
                  icon: AssetsConstant.home,
                  title: 'homeTab'.tr,
                ),
                AnimationButtonBar(
                  function: () {
                    value.changeTab(1);
                  },
                  check: value.currentIndex == 1,
                  icon: AssetsConstant.tabOffers,
                  title: 'offers'.tr,
                ),
                AnimationButtonBar(
                  function: () {
                    value.changeTab(3);
                  },
                  check: value.currentIndex == 3,
                  icon: AssetsConstant.drawerOrder,
                  title: 'orderHistory'.tr,
                ),
                AnimationButtonBar(
                  function: () {
                    value.changeTab(2);
                  },
                  check: value.currentIndex == 2,
                  icon: AssetsConstant.loyalty,
                  title: 'loyalty'.tr,
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}