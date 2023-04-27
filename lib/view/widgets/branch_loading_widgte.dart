import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/assets_constant.dart';

class BranchLoadingWidget extends StatelessWidget {
  const BranchLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              AssetsConstant.loading,
              width: Get.width,
              fit: BoxFit.cover,
              height: Get.height*.2,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    AssetsConstant.loading,
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
