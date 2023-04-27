import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../utils/helper.dart';
import '../../utils/theme/app_theme.dart';

class AddToCartDialog extends StatefulWidget {
  const AddToCartDialog({Key? key, this.isTop = false}) : super(key: key);
  final bool isTop;
  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  bool isFirstAnimate = false;
  bool isSecondAnimate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      isFirstAnimate = true;
      if (mounted) setState(() {});
      Future.delayed(Duration(milliseconds: 200), () {
        isSecondAnimate = true;
        if (mounted) setState(() {});
        Future.delayed(Duration(milliseconds: 200), () {
          isSecondAnimate = true;

          Get.back();

          Future.delayed(Duration(milliseconds: 400), () {
            // Get.back();
            Fluttertoast.cancel();
            Helper().successfullySnackBar('productAddedSuccessfully'.tr);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          duration: Duration(milliseconds: 350),
          alignment: isSecondAnimate
              ? widget.isTop
                  ? appLanguage == 'ar'
                      ? Alignment.topLeft
                      : Alignment.topRight
                  : Alignment.bottomCenter
              : Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 350),
            height: isFirstAnimate ? 100 : 0,
            width: isFirstAnimate ? 100 : 0,
            decoration:
            BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Center(child: Text("1",style: AppTheme.boldStyle(color: Colors.white,size: 25),)),
          ),
        )
      ],
    );
  }
}
