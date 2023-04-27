import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Marouf/main.dart';
import 'package:Marouf/models/main_response.dart';
import 'package:Marouf/view/screens/referral_screen.dart';
import 'package:Marouf/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/profile_model.dart';
import '../models/signup_model.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/constant/static_variables.dart';
import '../utils/device_info.dart';
import '../utils/helper.dart';
import '../view/screens/main_screen.dart';
import '../view/widgets/animated_shake_widget.dart';

class CompleteProfileViewModel extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();
  final TextEditingController spouseController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final firstKey = GlobalKey<ShakeWidgetState>();
  final lastKey = GlobalKey<ShakeWidgetState>();
  final genderKey = GlobalKey<ShakeWidgetState>();
  final birthdayKey = GlobalKey<ShakeWidgetState>();
  final materialKey = GlobalKey<ShakeWidgetState>();
  final anniversaryKey = GlobalKey<ShakeWidgetState>();
  final spouseKey = GlobalKey<ShakeWidgetState>();
  DeviceInfo deviceInfo = DeviceInfo();
  bool firstNameValidate = false;
  bool lastNameValidate = false;
  final bool isEdit;
  bool editBirthDate = false;
  bool editEmail = false;
  var selectedGender;
  bool isOpen = false;
  bool isMarred = false;
  var selectedMaterialState;
  bool isOpenGender = false;
  bool isOpenMaterial = false;
  final ProfileData? profile;

  CompleteProfileViewModel({this.isEdit = false, this.profile}) {
    if (isEdit) {
      firstNameController.text = profile!.firstName!;
      lastNameController.text = profile!.lastName!;

      print('fhgfxfgcf${profile!.birthDate}');
      // if (profile!.birthDate != null && profile!.birthDate != '') {
      //   birthdateController.text = getFormattedDate(profile!.birthDate!);
      //   editBirthDate = false;
      // } else {
      //   birthdateController.clear();
      //   editBirthDate = true;
      // }
      profile!.birthDate == null
          ? birthdateController.text = ''
          : birthdateController.text = getFormattedDate(profile!.birthDate!);
      companyController.text = profile!.companyName ?? '';
      genderController.text = getGender(profile!.genderType!).tr;
      selectedGender = getGender(profile!.genderType!);

      materialController.text = getMaterial(profile!.meritalStatusType!).tr;
      selectedMaterialState = getMaterial(profile!.meritalStatusType!);
    } else {
      SharedPreferences.getInstance().then((value) {
        number = value.getString(SharedPreferencesKey.mobileNumber) ?? '';
        mobileController.text = number;
      });
    }
  }

  String number = '';

  String getFormattedDate(String dateStr) {
    DateFormat formattedDate = DateFormat('yyyy-MM-dd');
    DateTime date = formattedDate.parse(dateStr);
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  void onInit() {
    super.onInit();
    deviceInfo.getDeviceInfo().then((value) {});
  }

  save() {
    if (firstNameValidate) {
      firstKey.currentState?.shake();
      print('first name');
    } else if (lastNameValidate) {
      lastKey.currentState?.shake();
      print('last name');
    } else if (birthdateController.text.isEmpty) {
      birthdayKey.currentState?.shake();
    } else if (selectedGender == null) {
      genderKey.currentState?.shake();
    } else {
      print('asdasd');
      SharedPreferences.getInstance().then((value) {
        accessToken = value.getString(SharedPreferencesKey.accessToken) ?? '';
        if (isEdit) {
          editProfile();
        } else {
          completeProfile();
        }
      });
    }
  }

  completeProfile() async {
    Map<String, String> body = {
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "BirthDate": birthdateController.text,
      "Gender": '${selectedGender == 'male' ? 1 : 2}',
      "CountryId": '113'
    };
    if (selectedMaterialState != null) {
      body.putIfAbsent("MaritalStatusId",
          () => '${selectedMaterialState == 'single' ? 1 : 2}');
    }
    if (spouseController.text.isNotEmpty) {
      body.putIfAbsent('WifeBirthdate', () => spouseController.text);
    }
    if (anniversaryController.text.isNotEmpty) {
      body.putIfAbsent('AnniversaryDate', () => anniversaryController.text);
    }
    Helper().loading();
    await HttpClientApp().request(
        method: 'PUT',
        url: APIUrls.updateProfile,
        body: body,
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        SharedPreferences.getInstance().then((value) async {
          bool? hasReferral = value.getBool(SharedPreferencesKey.hasReferral);
          value.setBool(SharedPreferencesKey.isComplete, true);
          if (hasReferral ?? false) {
            //goto Main screen
            Get.offAll(MainScreen(),
                duration: const Duration(seconds: 1),
                transition: Transition.fadeIn);
          } else {
            // goto Referral screen
            Get.offAll(ReferralScreen(),
                duration: const Duration(seconds: 1),
                transition: Transition.fadeIn);
          }
        });
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

  editProfile() async {
    Map<String, String> body = {
      "FirstName": firstNameController.text,
      "LastName": lastNameController.text,
      "BirthDate": birthdateController.text,
      "CompanyName": companyController.text,
      "Gender": '${selectedGender == 'male' ? 1 : 2}',
      // "MaritalStatusId": '${selectedMaterialState == 'single' ? 1 : 2}',
      "CountryId": '113'
    };

    print("++++++++++++++++++++++++++++++++++++++++ ${companyController.text}");
    Helper().loading();
    await HttpClientApp().request(
        method: 'PUT',
        url: APIUrls.updateProfile,
        body: body,
        files: {}).then((response) async {
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      Get.back();
      if (mainResponse.isSucceeded!) {
        ProfileViewModel viewModel = Get.find();
        viewModel.getProfile();
        Get.back();
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

  String getGender(int genderId) {
    switch (genderId) {
      case 1:
        selectedGender = 'male';
        break;
      case 2:
        selectedGender = 'female';
        break;
      default:
        selectedGender = 'gender';
        break;
    }
    update();
    print('getGender(profile!.genderType!);: ${selectedGender}');
    return selectedGender;
  }

  String getMaterial(int materialId) {
    switch (materialId) {
      case 1:
        selectedMaterialState = 'single';
        break;
      case 2:
        selectedMaterialState = 'married';
        break;
      default:
        selectedMaterialState = 'status_st';
        break;
    }
    update();
    print('getMaterial(profile!.genderType!);: ${selectedMaterialState}');
    return selectedMaterialState;
  }
}
