import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/models/address_cities.dart';
import 'package:Marouf/models/city_areas.dart';
import 'package:Marouf/models/user_address.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';
import 'package:Marouf/viewmodel/my_addresses_viewmodel.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/navigation.dart';
import '../../utils/theme/app_theme.dart';
import 'address_map_screen.dart';

class AddAddressDetailsScreen extends StatelessWidget {
  const AddAddressDetailsScreen({Key? key, required this.isEdit, this.address})
      : super(key: key);
  final bool isEdit;
  final Addresses? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(
            color: AppTheme.colorAccent
        ),
        title: Text(
          'addNewAddress'.tr,
          style: AppTheme.lightStyle(color: AppTheme.colorAccent, size: 16.sp),
        ),
      ),
      body: GetBuilder<MyAddressesViewModel>(
          builder: (controller) {
        return SingleChildScrollView(
          child: Form(
            key: controller.addAddressFormKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: Get.height * .25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AssetsConstant.worldMap,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      NavigationApp.to(AddressMapScreen(
                        initialCamera: CameraPosition(
                          target: controller.selectedPosition,
                          zoom: 15.0,
                        ),
                        isEdit: true,
                      ));
                    },
                    child: Chip(
                      side: const BorderSide(
                          width: 1, color: AppTheme.colorAccent),
                      backgroundColor: Colors.white,
                      avatar: const Icon(
                        Icons.circle,
                        color: AppTheme.colorAccent,
                      ),
                      label: Text(
                        controller.addressDetails != 'address'.tr
                            ? controller.addressDetails
                            : 'selectYourAddress'.tr,
                        textAlign: TextAlign.center,
                        style: AppTheme.lightStyle(
                            color: Colors.black, size: 16.sp),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Text("And".tr),
                      Expanded(child: Divider())
                    ],
                  ),
                ),
                ShakeWidget(
                  key: controller.labelSakeKey,
                  shakeOffset: 10,
                  shakeCount: 2,
                  shakeDuration: const Duration(milliseconds: 800),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetsConstant.addressLabel,
                            width: Get.width * .08,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('addressLabel'.tr,
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changeSelectedLabel('home'.tr);
                                      },
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: 'home'.tr,
                                            groupValue:
                                            controller.selectedLabel,
                                            fillColor:
                                            MaterialStateProperty.all(
                                                AppTheme.colorAccent),
                                            onChanged: (val) {
                                              controller
                                                  .changeSelectedLabel(val!);
                                            },
                                          ),
                                          Text('home'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black54,size: 12.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changeSelectedLabel('work'.tr);
                                      },
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: 'work'.tr,
                                            groupValue:
                                            controller.selectedLabel,
                                            fillColor:
                                            MaterialStateProperty.all(
                                                AppTheme.colorAccent),
                                            onChanged: (val) {
                                              controller
                                                  .changeSelectedLabel(val!);
                                            },
                                          ),
                                          Text('work'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black54,size: 12.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changeSelectedLabel('other'.tr);
                                      },
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: 'other'.tr,
                                            groupValue:
                                            controller.selectedLabel,
                                            fillColor:
                                            MaterialStateProperty.all(
                                                AppTheme.colorAccent),
                                            onChanged: (val) {
                                              controller
                                                  .changeSelectedLabel(val!);
                                            },
                                          ),
                                          Text('other'.tr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black54,size: 12.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.selectedLabel == 'other'.tr)
                                TextFormField(
                                  controller: controller.otherLabelController,
                                  decoration: InputDecoration(
                                    counter: Container(
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    hintText: 'addressLabel'.tr +
                                        'addressLabelList'.tr,
                                    border: InputBorder.none,
                                  ),
                                ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Icon(
                            Icons.star_sharp,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShakeWidget(
                  key: controller.detailSakeKey,
                  shakeOffset: 10,
                  shakeCount: 2,
                  shakeDuration: const Duration(milliseconds: 800),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  //  controller.addressDetails
                                  controller: controller.detailController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                      counter: Container(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Column(
                                        children: const [
                                          Icon(
                                            Icons.star_sharp,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      hintText: 'addressDetails'.tr,
                                      border: InputBorder.none,
                                      icon: Image.asset(
                                        AssetsConstant.detailsAddress,
                                        height: 30,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShakeWidget(
                  key: controller.citySakeKey,
                  shakeOffset: 10,
                  shakeCount: 2,
                  shakeDuration: const Duration(milliseconds: 800),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetsConstant.city,
                            width: Get.width * .08,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<CityModel?>(
                              isExpanded: true,
                              value: controller.selectedCity,
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              hint: Column(
                                children: [
                                  Text('city'.tr),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                              items: controller.addressCities
                                  .toList()
                                  .map((CityModel? value) {
                                return DropdownMenuItem<CityModel>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('${value!.name}'),
                                  ),
                                );
                              }).toList(),
                              onChanged: (_) {
                                controller.selectedCity = _;
                                controller.update();
                                controller.selectedArea=null;
                                controller.getCityAreas(_!.id);
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Icon(
                            Icons.star_sharp,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShakeWidget(
                  key: controller.areaSakeKey,
                  shakeOffset: 10,
                  shakeCount: 2,
                  shakeDuration: const Duration(milliseconds: 800),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetsConstant.city,
                            width: Get.width * .08,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<AreaModel?>(
                              isExpanded: true,
                              value: controller.selectedArea,
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              hint: Column(
                                children: [
                                  Text('area'.tr),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                              items: controller.cityAreas
                                  .toList()
                                  .map((AreaModel? value) {
                                return DropdownMenuItem<AreaModel>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('${value!.name}'),
                                  ),
                                );
                              }).toList(),
                              onChanged: (_) {
                                controller.selectedArea = _;
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Icon(
                            Icons.star_sharp,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShakeWidget(
                  key: controller.buildSakeKey,
                  shakeOffset: 10,
                  shakeCount: 2,
                  shakeDuration: const Duration(milliseconds: 800),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller:
                                  controller.buildingNumberController,
                                  decoration: InputDecoration(
                                      counter: Container(
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                      hintText: 'buildingNum'.tr,
                                      border: InputBorder.none,
                                      suffixIcon: Column(
                                        children: const [
                                          Icon(
                                            Icons.star_sharp,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      icon: Image.asset(
                                        AssetsConstant.buildingNum,
                                        height: 30,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: controller.floorNumberController,
                                decoration: InputDecoration(
                                    counter: Container(
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    hintText: 'floorNum'.tr,
                                    border: InputBorder.none,
                                    // suffixIcon: Column(
                                    //   children: const [
                                    //     Icon(
                                    //       Icons.star_sharp,
                                    //       color: Colors.red,
                                    //       size: 16,
                                    //     ),
                                    //   ],
                                    // ),
                                    icon: Image.asset(
                                      AssetsConstant.floorNum,
                                      height: 30,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller:
                                controller.apartmentNumberController,
                                decoration: InputDecoration(
                                    counter: Container(
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    hintText: 'apartment'.tr,
                                    border: InputBorder.none,
                                    // suffixIcon: Column(
                                    //   children: const [
                                    //     Icon(
                                    //       Icons.star_sharp,
                                    //       color: Colors.red,
                                    //       size: 16,
                                    //     ),
                                    //   ],
                                    // ),
                                    icon: Image.asset(
                                      AssetsConstant.apartment,
                                      height: 30,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.validateFormAndSubmit(isEdit: isEdit,id: address?.id);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [BoxShadow()],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'save'.tr,
                            style: AppTheme.lightStyle(
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
