import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../viewmodel/filter_viewmodel.dart';
import '../../viewmodel/search_products_viewmodel.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchOrderViewModel>(
        init: SearchOrderViewModel(isFilters: true),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppTheme.colorAccent),
              title: Text(
                "filters".tr,
                style: AppTheme.lightStyle(
                    color: AppTheme.colorAccent, size: 18.sp),
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              controller: controller.scrollControllerFilter,
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.filtersFilter.length + 1,
              itemBuilder: (_, index) => index ==
                      controller.filtersFilter.length
                  ? (controller.isLoadMoreRunningFilter
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.colorPrimary),
                        )
                      : const SizedBox())
                  : CheckboxListTile(
                      value: controller.selectedFilters
                          .contains(controller.filtersFilter[index]),
                      onChanged: (value) {
                        controller.saveFilterValue(
                            value!, controller.filtersFilter[index]);
                      },
                      title: Text("${controller.filtersFilter[index].name}"),
                    ),
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    controller.selectedFilters.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.selectedFilters.clear();
                                  controller.update();
                                },
                                child: Text("clear".tr),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    minimumSize:
                                        Size(Get.width * .45, Get.height * .05),
                                    backgroundColor: AppTheme.colorDrawerColor)),
                          )
                        : SizedBox()
                    , ElevatedButton(
                      onPressed: () {
                        print(controller.selectedFilters);
                        Get.to(SearchScreen());
                        controller.refreshScreen();
                      },
                      child: Text("done".tr),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(
                              controller.selectedFilters.isEmpty
                                  ? Get.width * .95
                                  : Get.width * .45,
                              Get.height * .05),
                          backgroundColor: AppTheme.colorAccent),
                    ),
                  ],
                )),
          );
        });
  }
}
