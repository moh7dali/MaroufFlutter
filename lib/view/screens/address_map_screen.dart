import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Marouf/utils/navigation.dart';
import 'package:Marouf/view/screens/add_address_details_screen.dart';
import 'package:Marouf/viewmodel/my_addresses_viewmodel.dart';

import '../../utils/theme/app_theme.dart';
import '../../viewmodel/cart_viewmodel.dart';

class AddressMapScreen extends StatefulWidget {
  AddressMapScreen({
    Key? key,
    required this.initialCamera,
    required this.isEdit,
    this.cartViewModel,
    this.isCartAddress = false,
    this.isCart = false,
  }) : super(key: key);
  CameraPosition initialCamera;

  bool isEdit;
  bool isCart;
  final bool isCartAddress;
  final CartViewModel? cartViewModel;

  @override
  State<AddressMapScreen> createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  bool _compassEnabled = true;
  bool _mapToolbarEnabled = true;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MapType _mapType = MapType.normal;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomControlsEnabled = false;
  bool _zoomGesturesEnabled = true;
  bool _indoorViewEnabled = true;
  bool _myLocationEnabled = true;
  bool _myTrafficEnabled = false;
  bool _myLocationButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesViewModel>(
      init: MyAddressesViewModel(
          cartViewModel: widget.cartViewModel,
          isCartAddress: widget.isCartAddress),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: AppTheme.colorAccent),
          title: Text(
            'selectYourAddress'.tr,
            style:
            AppTheme.lightStyle(color: AppTheme.colorAccent, size: 16.sp),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: widget.initialCamera,
              compassEnabled: _compassEnabled,
              mapToolbarEnabled: _mapToolbarEnabled,
              cameraTargetBounds: _cameraTargetBounds,
              minMaxZoomPreference: _minMaxZoomPreference,
              mapType: _mapType,
              rotateGesturesEnabled: _rotateGesturesEnabled,
              scrollGesturesEnabled: _scrollGesturesEnabled,
              tiltGesturesEnabled: _tiltGesturesEnabled,
              zoomGesturesEnabled: _zoomGesturesEnabled,
              zoomControlsEnabled: _zoomControlsEnabled,
              indoorViewEnabled: _indoorViewEnabled,
              myLocationEnabled: _myLocationEnabled,
              myLocationButtonEnabled: _myLocationButtonEnabled,
              trafficEnabled: _myTrafficEnabled,
              onCameraIdle: () {
                controller.getLocationName();
              },
              onCameraMove: (c) {
                controller.selectedPosition = c.target;
              },
            ),
            Positioned(
              bottom: 26,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border:
                        Border.all(color: AppTheme.colorAccent, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Icon(Icons.circle, color: AppTheme.colorAccent),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: BorderedText(
                              strokeWidth: 1.0,
                              strokeColor: AppTheme.colorAccent,
                              child: Text(
                                controller.addressDetails,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: AppTheme.lightStyle(
                                    color: Colors.black, size: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.isEdit) {
                        Get.back();
                        controller.detailController.text =
                            controller.addressDetails;
                      } else {
                        controller.clearFields();
                        controller.detailController.text =
                            controller.addressDetails;
                        controller.update();
                        NavigationApp.to(const AddAddressDetailsScreen(
                          isEdit: false,
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.colorAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BorderedText(
                              strokeWidth: 1.0,
                              strokeColor: AppTheme.colorAccent,
                              child: Text(
                                'selectYourAddress'.tr,
                                style: AppTheme.lightStyle(
                                    color: Colors.white, size: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  heroTag: 'recenterr',
                  onPressed: () {
                    controller.reCenterCamera();
                  },
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.grey,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xFFECEDF1))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IgnorePointer(
                ignoring: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.location_on_outlined,
                      size: 50,
                      color: AppTheme.colorAccent,
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      size: 50,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
