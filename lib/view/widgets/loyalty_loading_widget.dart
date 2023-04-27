import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';

class LoyaltyLoadingWidget extends StatelessWidget {
  const LoyaltyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              AssetsConstant.logo,
              width: Get.width*.5,
              height: Get.height * .25,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 40,
              width: Get.width * .5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsConstant.loading),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsConstant.loading),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsConstant.loading),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 40,
                    width: Get.width * .25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsConstant.loading),
                            fit: BoxFit.cover)),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 40,
                    width: Get.width * .25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsConstant.loading),
                            fit: BoxFit.cover)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsConstant.loading),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsConstant.loading),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
