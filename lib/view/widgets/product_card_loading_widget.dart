import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';

class ProductCardLoadingWidget extends StatelessWidget {
  const ProductCardLoadingWidget({Key? key,this.count }) : super(key: key);
  final int? count;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: count??5,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.asset(
                    AssetsConstant.loading,
                    height: Get.width,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
