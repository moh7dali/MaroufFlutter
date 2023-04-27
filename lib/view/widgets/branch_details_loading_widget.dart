import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';

class BranchDetailsLoading extends StatelessWidget {
  const BranchDetailsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(
                AssetsConstant.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height * .28,
              ),
              SizedBox(height: 8),
              Image.asset(
                AssetsConstant.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height * .04,
              ),
              SizedBox(height: 8),
              Image.asset(
                AssetsConstant.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height * .04,
              ),
              SizedBox(height: 8),
              Image.asset(
                AssetsConstant.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height * .04,
              ),
              SizedBox(height: 8),
              Image.asset(
                AssetsConstant.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height * .04,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround
            ,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  AssetsConstant.loading,
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                ),
              ),ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  AssetsConstant.loading,
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
