import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Marouf/models/user_address.dart';
import 'package:Marouf/utils/gms_hms_service.dart';
import 'package:Marouf/view/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/address_cities.dart';
import '../models/city_areas.dart';
import '../models/main_response.dart';
import '../utils/helper.dart';
import '../utils/location_helper.dart';
import '../view/widgets/animated_shake_widget.dart';
import 'cart_viewmodel.dart';

class MyAddressesViewModel extends GetxController {
  Completer<GoogleMapController> completerController = Completer();
  final CartViewModel? cartViewModel;
  final addAddressFormKey = GlobalKey<FormState>();
  final detailSakeKey = GlobalKey<ShakeWidgetState>();
  final citySakeKey = GlobalKey<ShakeWidgetState>();
  final areaSakeKey = GlobalKey<ShakeWidgetState>();
  final labelSakeKey = GlobalKey<ShakeWidgetState>();
  final buildSakeKey = GlobalKey<ShakeWidgetState>();
  final detailController = TextEditingController();
  final otherLabelController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final floorNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  String? selectedOtherLabel;
  late GoogleMapController _controller;
  LatLng currentLocation = const LatLng(31.996499, 35.848011);
  bool isStart = true;
  LatLng selectedPosition = const LatLng(31.996499, 35.848011);
  GoogleMapController? googleMapController;
  String addressDetails = 'address'.tr;
  String selectedLabel = 'home'.tr;
  CityModel? selectedCity;
  AreaModel? selectedArea;
  List<CityModel> addressCities = [];
  List<Addresses> myAddresses = [];
  List<AreaModel> cityAreas = [];
  Addresses? selectedAddress;
  bool isLoading = true;
  final bool isCartAddress;
  bool hasAddress = false;

  final CameraPosition initialCamera = const CameraPosition(
    target: LatLng(31.996499, 35.848011),
    zoom: 11.0,
  );

  MyAddressesViewModel({this.cartViewModel, this.isCartAddress = false});

  @override
  void onInit() {
    super.onInit();
    LocationHelper.requestLocationPermission(
      () {
        Geolocator.getCurrentPosition().then((value) {
          currentLocation = LatLng(value.latitude, value.longitude);
        });
      },
    );
    getUserAddress();
    getAddressCities();
  }

  getUserAddress() async {
    isLoading = true;
    myAddresses.clear();
    update();
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getUserAddresses,
      body: {},
      files: {},
    ).then((response) async {
      isLoading = false;
      update();
      if (json.decode(response)['Addresses'] != null) {
        UserAddress addresses = UserAddress.fromJson(json.decode(response));
        addresses.addresses!.forEach((element) {
          myAddresses.add(element);
        });
        if (addresses.addresses!.isNotEmpty) {
          selectedAddress = addresses.addresses!.first;
          cartViewModel?.getDeliveryFee(selectedAddress!.id!);
          hasAddress = true;
          update();
        }
      }
    });
  }

  getCityAreas(cityId) async {
    cityAreas = [];
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getAreas}?cityId=$cityId',
      body: {},
      files: {},
    ).then((response) async {
      CityAreas areas = CityAreas.fromJson(json.decode(response));
      cityAreas = areas.areasList!;
      update();
    });
  }

  changeSelectedLabel(String label) {
    selectedLabel = label;
    update();
  }

  getAddressCities() async {
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getCities + '?countryId=113',
      body: {},
      files: {},
    ).then((response) async {
      AddressCities addresses = AddressCities.fromJson(json.decode(response));
      addresses.citiesList!.forEach((element) {
        addressCities.add(element);
      });

      update();
    });
  }

  deleteAddress(int id) async {
    await HttpClientApp().request(
        method: 'POST',
        url: '${APIUrls.deleteAddress}/$id',
        body: {},
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        myAddresses.removeWhere((element) => element.id == id);
        Helper().successfullySnackBar('addressDeletedSuccessfully'.tr);
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    Helper().loading();
    LocationHelper.requestLocationPermission(() {
      Geolocator.getCurrentPosition().then((value) {
        currentLocation = LatLng(value.latitude, value.longitude);
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 15,
        )));
        if (Get.isOverlaysOpen) {
          Get.back();
        }
      });
    });
  }

  reCenterCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: currentLocation,
      zoom: 14,
    )));
  }

  getLocationName() async {
    List<String> placeList = [];

    await placemarkFromCoordinates(
            selectedPosition.latitude, selectedPosition.longitude,
            localeIdentifier: 'en')
        .then((value) {
      print(value.first.toJson());
      if (value.first.locality != null && value.first.locality!.length > 1) {
        placeList.add(value.first.locality!);
      }
      if (value.first.subLocality != null &&
          value.first.subLocality!.length > 1) {
        placeList.add(value.first.subLocality!);
      }
      if (value.first.name != null) {
        placeList.add(value.first.name!);
      }
      addressDetails = placeList.join(',');
      update();
      print(placeList);
    });
  }

  validateFormAndSubmit({bool isEdit = false, int? id}) {
    if (detailController.text.isEmpty) {
      detailSakeKey.currentState!.shake();
    } else if (selectedCity == null) {
      citySakeKey.currentState!.shake();
    } else if (selectedArea == null) {
      areaSakeKey.currentState!.shake();
    } else if (selectedLabel == 'other'.tr &&
        otherLabelController.text.isEmpty) {
      labelSakeKey.currentState!.shake();
    }else if (buildingNumberController.text.isEmpty) {
      buildSakeKey.currentState!.shake();
    } else {
      var body = {
        "Address": detailController.text,
        "Name": selectedLabel == 'other'.tr
            ? otherLabelController.text
            : selectedLabel,
        "CityId": "${selectedCity!.id!}",
        "AreaId": "${selectedArea!.id!}",
        "Latitude": "${selectedPosition.latitude}",
        "Longitude": "${selectedPosition.longitude}",
        "BuildingNumber":buildingNumberController.text
      };
      if (floorNumberController.text.isNotEmpty) {
        body.putIfAbsent('Floor', () => floorNumberController.text);
      }
      if (apartmentNumberController.text.isNotEmpty) {
        body.putIfAbsent('Apartment', () => apartmentNumberController.text);
      }
      if (isEdit) {
        body.putIfAbsent('id', () => '${id!}');
      }
      if (isEdit) {
        updateAddress(body);
      } else {
        addNewAddress(body);
      }
    }
  }

  addNewAddress(Map<String, String> body) async {
    Helper().loading();
    await HttpClientApp().request(
        method: 'POST',
        url: APIUrls.addAddress,
        body: body,
        files: {}).then((response) async {
      print("add (((((((${response})))))))");
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        getUserAddress();
        clearFields();
        Get.back();
        Get.back();
        Helper().successfullySnackBar('addressAddedSuccessfully'.tr);
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      log(response, name: 'sendNumber');
    });
  }

  updateAddress(Map<String, String> body) async {
    Helper().loading();
    await HttpClientApp().request(
        method: 'POST',
        url: APIUrls.updateAddress,
        body: body,
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        getUserAddress();
        // clearFields();
        Get.back();
        Helper().successfullySnackBar('addressUpdatedSuccessfully'.tr);
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      log(response, name: 'sendNumber');
    });
  }

  clearFields()
  {
    floorNumberController.clear();
    apartmentNumberController.clear();
    buildingNumberController.clear();
    otherLabelController.clear();
    detailController.clear();
    selectedCity = null;
    selectedArea = null;
    selectedLabel = 'home'.tr;
    update();
  }

  setFields({buildNum, String? label, lat, lng, city, details, area,floorNum,
    apartmentNum}) {
    buildingNumberController.text = buildNum;
    floorNumberController.text = floorNum;
    apartmentNumberController.text = apartmentNum;
    otherLabelController.text = label!;
    detailController.text = details;
    selectedCity = addressCities.firstWhere((element) => element.id == city);
    cityAreas = [];
    selectedArea = null;
    getCityAreas(city).then((value) {
      selectedArea = cityAreas.firstWhere((element) => element.id == area);
    });
    if (label.tr != 'home'.tr && label.tr != 'work'.tr) {
      selectedLabel = 'other'.tr;
    } else {
      selectedLabel = label.tr;
    }
    selectedPosition = LatLng(lat, lng);
    getLocationName();

    update();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
