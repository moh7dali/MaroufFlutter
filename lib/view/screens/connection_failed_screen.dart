import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constant/assets_constant.dart';
import '../widgets/no_items_widget.dart';

class ConnectionFailedScreen extends StatelessWidget {
  const ConnectionFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Stack(
      children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                AssetsConstant.connectUsBack,
                fit: BoxFit.cover,
              )),
          NoItemsWidget(
              img: AssetsConstant.noNetwork,
              title:
                  appLanguage == 'ar' ? "لا يوجد اتصال بالإنترنت" : "No Internet",
              body: appLanguage == 'ar'
                  ? "يرجى التحقق من الاتصال بالإنترنت"
                  : "Please check your internet connection")
      ],
    ),
        ));
  }
}
