import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/viewmodel/transfer_points_viewmodel.dart';

import '../../../utils/constant/assets_constant.dart';
import '../../../utils/theme/app_theme.dart';

class TransferPointsScreen extends StatelessWidget {
  String transferDPoints = "";
  String phoneNo = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferPointsViewModel>(
        init: TransferPointsViewModel(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(AssetsConstant.transferPoints,
                      fit: BoxFit.cover),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        AppBar(
                          centerTitle: false,
                          backgroundColor: Colors.transparent,
                          iconTheme: IconThemeData(color: Colors.black),
                          title: Text('transferPoints'.tr,
                              style: AppTheme.boldStyle(
                                  color: Colors.black, size: 20)),
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "myPoints".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.08),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${controller.currentPoints.balance??0}' ,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.08),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "transfer".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.08),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: controller.pointsTransfer,
                                        style: TextStyle(
                                          color: AppTheme.colorAccent,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'points'.tr,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                          errorMaxLines: 3
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (text) {
                                          if (text!.isEmpty) {
                                            return "pointsValidationChar".tr;
                                          }else if(!text.isNumericOnly) {
                                            return "pointsValidationNum".tr;
                                          }
                                          else if (text.length < 3)
                                            {
                                              return "lessThan".tr;
                                            }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  )
                                ],
                              ),
                              Text(
                                "transferMessage".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04,
                                ),
                              ),
                              Row(
                                textDirection: TextDirection.rtl,

                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: controller.phoneNo,
                                        style: TextStyle(
                                          color: AppTheme.colorAccent,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'phoneNo'.tr,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.colorAccent)),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (text) {
                                          if (text!.isEmpty) {
                                            return "phoneNoValidationNum".tr;
                                          }
                                          else if (text.length<9)
                                            {
                                              return "wrongPhoneNoValidationNum".tr;
                                            }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "jordan".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.05),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Container(
                                  //
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              GestureDetector(
                                onTap:(){
                                  controller.transferPoints();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 0.0, left: 10.0, right: 10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.colorAccent,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppTheme.colorAccent,
                                      )),
                                  child: Text(
                                    "transfer".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width * 0.08),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}


