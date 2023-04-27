import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/helper.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/add_address_details_screen.dart';
import 'package:Marouf/view/screens/address_map_screen.dart';
import 'package:Marouf/view/widgets/no_items_widget.dart';
import 'package:Marouf/viewmodel/my_addresses_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/location_helper.dart';
import '../../utils/theme/app_theme.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesViewModel>(
        init: MyAddressesViewModel(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                centerTitle: false,
                iconTheme: IconThemeData(color: AppTheme.colorAccent),
                title: Text(
                  'myAddresses'.tr,
                  style: AppTheme.lightStyle(
                      color: AppTheme.colorAccent, size: 16.sp),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        LocationHelper.requestLocationPermission(() {
                          NavigationApp.to(AddressMapScreen(
                            initialCamera: CameraPosition(
                              target: controller.selectedPosition,
                              zoom: 11.0,
                            ),
                            isEdit: false,
                          ));
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.colorPrimary,
                                ),
                                height: Get.height * .1,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.location_on_outlined,
                                    color: AppTheme.colorPrimary, size: 50),
                              ),
                              Text(
                                'addNewAddress'.tr,
                                style: AppTheme.lightStyle(
                                    color: AppTheme.colorAccent, size: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller.isLoading
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  AssetsConstant.loading),
                                              fit: BoxFit.cover)),
                                      height: Get.height * .1,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            decoration: const BoxDecoration(
                                              color: AppTheme.colorAccent,
                                            ),
                                            height: Get.height * .1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.colorAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          AssetsConstant
                                                              .loading),
                                                      fit: BoxFit.cover)),
                                              height: Get.height * .1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 30),
                                            child: Container(
                                              width: Get.width * .6,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.colorAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          AssetsConstant
                                                              .loading),
                                                      fit: BoxFit.cover)),
                                              height: Get.height * .1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : controller.myAddresses.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top:150),
                              child: Center(
                                child: NoItemsWidget(
                                    hasColor: true,
                                    isSmall: true,
                                    img: AssetsConstant.noAddresses,
                                    title: 'noAddresses'.tr,
                                  ),
                              ),
                            )
                            : Expanded(
                                child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'swipe'.tr,
                                          style: AppTheme.lightStyle(
                                              color: Colors.grey.shade300,
                                              size: 16.sp),
                                        ),
                                      ),
                                      Icon(Icons.swipe,
                                          color: Colors.grey.shade300,
                                          size: 16.sp),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.myAddresses.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Container(
                                          height: Get.height * .1,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Dismissible(
                                              secondaryBackground: Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Icon(Icons.edit,
                                                          color: Colors
                                                              .transparent,
                                                          size: 30),
                                                      Icon(
                                                          Icons
                                                              .delete_forever_outlined,
                                                          color: Colors.white,
                                                          size: 30),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              background: Container(
                                                color: AppTheme.colorPrimary,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Icon(Icons.edit,
                                                          color: Colors.white,
                                                          size: 30),
                                                      Icon(
                                                          Icons
                                                              .delete_forever_outlined,
                                                          color: Colors
                                                              .transparent,
                                                          size: 30),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onDismissed: (direction) {
                                                print('onDismissed $direction');
                                              },
                                              confirmDismiss:
                                                  (direction) async {
                                                print(
                                                    'confirmDismiss $direction');
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart) {
                                                  controller.deleteAddress(
                                                      controller
                                                          .myAddresses[index]
                                                          .id!);
                                                  return true;
                                                } else {
                                                  LocationHelper
                                                      .requestLocationPermission(
                                                          () {
                                                    controller.setFields(
                                                      floorNum: controller
                                                          .myAddresses[index]!
                                                          .floor,
                                                      apartmentNum: controller
                                                          .myAddresses[index]!
                                                          .apartment,
                                                      label: controller
                                                          .myAddresses[index]
                                                          .name,
                                                      buildNum: controller
                                                              .myAddresses[
                                                                  index]
                                                              .buildingNumber ??
                                                          '',
                                                      city: controller
                                                          .myAddresses[index]
                                                          .cityId,
                                                      details: controller
                                                          .myAddresses[index]
                                                          .address,
                                                      lat: controller
                                                          .myAddresses[index]
                                                          .latitude,
                                                      lng: controller
                                                          .myAddresses[index]
                                                          .longitude,
                                                      area: controller
                                                          .myAddresses[index]
                                                          .areaId,
                                                    );
                                                    NavigationApp.to(
                                                        AddAddressDetailsScreen(
                                                      isEdit: true,
                                                      address: controller
                                                          .myAddresses[index],
                                                    ));
                                                  });
                                                  return false;
                                                }
                                              },
                                              key: GlobalKey(),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                    ),
                                                    height: Get.height * .1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Icon(
                                                        controller
                                                                    .myAddresses[
                                                                        index]
                                                                    .name!
                                                                    .toLowerCase()
                                                                    .tr ==
                                                                'home'.tr
                                                            ? Icons
                                                                .house_outlined
                                                            : controller
                                                                        .myAddresses[
                                                                            index]
                                                                        .name!
                                                                        .toLowerCase()
                                                                        .tr ==
                                                                    'work'.tr
                                                                ? Icons
                                                                    .work_outline_rounded
                                                                : Icons
                                                                    .location_on_outlined,
                                                        color: AppTheme
                                                            .colorPrimary,
                                                        size: 50),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .myAddresses[
                                                                    index]
                                                                .name!
                                                                .toLowerCase()
                                                                .tr,
                                                            style: AppTheme.lightStyle(
                                                                color: AppTheme
                                                                    .colorAccent,
                                                                size: 16.sp),
                                                          ),
                                                          Text(
                                                            '${controller.myAddresses[index].cityName!}, ${controller.myAddresses[index].address!}, ${controller.myAddresses[index].buildingNumber ?? ''}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: AppTheme.lightStyle(
                                                                color: AppTheme
                                                                    .colorAccent,
                                                                size: 14.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 16,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ))
                  ],
                ),
              ),
            ));
  }
}
