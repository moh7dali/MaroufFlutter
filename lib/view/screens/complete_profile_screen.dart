import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/date_picker_widget.dart';
import 'package:Marouf/viewmodel/complete_profile_viewmodel.dart';

import '../../models/profile_model.dart';
import '../widgets/animated_shake_widget.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen(
      {Key? key, this.isEdit = false, this.productsModel})
      : super(key: key);

  final ProfileData? productsModel;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<CompleteProfileViewModel>(
        init: CompleteProfileViewModel(isEdit: isEdit, profile: productsModel),
        builder: (controller) => Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child:
              Image.asset(AssetsConstant.completeProfileBack, fit: BoxFit.cover),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (!isEdit)
                          AppBar(
                            backgroundColor: Colors.transparent,
                          ),
                        if (!isEdit)
                          Text('completeProfile'.tr,
                              style: AppTheme.boldStyle(
                                  color:Colors.white, size: 18.sp)),
                        if (isEdit)
                          AppBar(
                            centerTitle: false,
                            backgroundColor: Colors.transparent,
                            iconTheme: const IconThemeData(
                                color:Colors.white),
                            title: isEdit
                                ? Text('editProfile'.tr,
                                style: AppTheme.boldStyle(
                                    color:Colors.white, size: 20))
                                : null,
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ShakeWidget(
                                  key: controller.firstKey,
                                  shakeOffset: 10,
                                  shakeCount: 2,
                                  shakeDuration:
                                  const Duration(milliseconds: 800),
                                  child: TextFormField(
                                    cursorColor:Colors.white,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.center,
                                    controller: controller.firstNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        controller.firstNameValidate = true;
                                        controller.update();
                                      } else {
                                        controller.firstNameValidate = false;
                                        controller.update();
                                      }
                                      return null;
                                    },
                                    textDirection: TextDirection.ltr,
                                    style: AppTheme.lightStyle(
                                        color:Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        hintText: 'firstName'.tr,
                                        alignLabelWithHint: true,
                                        counter: Container(
                                          height: 0,
                                        ),
                                        hintTextDirection: TextDirection.ltr,
                                        hintStyle: AppTheme.lightStyle(
                                            color:Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ShakeWidget(
                                  key: controller.lastKey,
                                  shakeOffset: 10,
                                  shakeCount: 2,
                                  shakeDuration:
                                  const Duration(milliseconds: 800),
                                  child: TextFormField(
                                    cursorColor:Colors.white,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.center,
                                    controller: controller.lastNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        controller.lastNameValidate = true;
                                        controller.update();
                                      } else {
                                        controller.lastNameValidate = false;
                                        controller.update();
                                      }

                                      return null;
                                    },
                                    textDirection: TextDirection.ltr,
                                    style: AppTheme.lightStyle(
                                        color:Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        hintText: 'lastName'.tr,
                                        alignLabelWithHint: true,
                                        counter: Container(
                                          height: 0,
                                        ),
                                        hintTextDirection: TextDirection.ltr,
                                        hintStyle: AppTheme.lightStyle(
                                            color:Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            !isEdit || controller.profile!.birthDate == null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ShakeWidget(
                                      key: controller.birthdayKey,
                                      shakeOffset: 10,
                                      shakeCount: 2,
                                      shakeDuration: const Duration(
                                          milliseconds: 800),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(
                                              new FocusNode());
                                          final dateFormat =
                                          intl.DateFormat(
                                              'yyyy-MM-dd');
                                          if (controller
                                              .birthdateController
                                              .text
                                              .isEmpty) {
                                            controller.birthdateController
                                                .text =
                                                dateFormat.format(
                                                    DateTime(2000));
                                            controller.update();
                                          }
                                          Get.bottomSheet(
                                              DatePickerWidget(
                                                  controller
                                                      .birthdateController,
                                                  controller));
                                        },
                                        child: TextFormField(
                                          readOnly: true,
                                          cursorColor:
                                         Colors.white,
                                          enabled: false,
                                          keyboardType:
                                          TextInputType.name,
                                          textAlign: TextAlign.center,
                                          controller: controller
                                              .birthdateController,
                                          textDirection:
                                          TextDirection.ltr,
                                          style: AppTheme.lightStyle(
                                              color:
                                             Colors.white),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors
                                                  .transparent,
                                              disabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      100),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(100),
                                                  borderSide: const BorderSide(color:Colors.white, width: 2)),
                                              hintText: 'birthdate'.tr,
                                              alignLabelWithHint: true,
                                              counter: Container(
                                                height: 0,
                                              ),
                                              hintTextDirection: TextDirection.ltr,
                                              hintStyle: AppTheme.lightStyle(color:Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox()
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child:  ShakeWidget(
                                  key: controller.genderKey,
                                  shakeOffset: 10,
                                  shakeCount: 2,
                                  shakeDuration:
                                  const Duration(milliseconds: 800),
                                  child: TextFormField(
                                    cursorColor:Colors.white,
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      controller.isOpenGender =
                                      !controller.isOpenGender;
                                      controller.update();
                                    },
                                    readOnly: true,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.center,
                                    controller: controller.genderController,
                                    textDirection: TextDirection.ltr,
                                    style: AppTheme.lightStyle(
                                        color:Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 20),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 26.0),
                                          child: Icon(
                                            controller.isOpenGender
                                                ? Icons.keyboard_arrow_up_outlined
                                                : Icons
                                                .keyboard_arrow_down_outlined,
                                            color:Colors.white,
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 26.0),
                                          child: Icon(
                                            controller.isOpenGender
                                                ? Icons.keyboard_arrow_up_outlined
                                                : Icons
                                                .keyboard_arrow_down_outlined,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            borderSide: const BorderSide(
                                                color:Colors.white,
                                                width: 2)),
                                        hintText: 'gender'.tr,
                                        alignLabelWithHint: true,
                                        counter: Container(
                                          height: 0,
                                        ),
                                        hintTextDirection: TextDirection.ltr,
                                        hintStyle: AppTheme.lightStyle(
                                            color:Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Expanded(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: controller.isOpenGender
                                        ? MediaQuery.of(context).size.height *
                                        0.07
                                        : 0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:Colors.white,
                                            width: 2),
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AnimatedOpacity(
                                            opacity:
                                            controller.isOpenGender ? 1 : 0,
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            child: Visibility(
                                              visible: controller.isOpenGender,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 18.0),
                                                child: RadioTheme(
                                                  data: RadioThemeData(
                                                    overlayColor:
                                                    MaterialStateProperty
                                                        .all(Colors.white),
                                                    fillColor:
                                                    MaterialStateProperty
                                                        .all(Colors.white),
                                                  ),
                                                  child: RadioListTile(
                                                    contentPadding:
                                                    const EdgeInsets.all(0),
                                                    title: Row(
                                                      children: [
                                                        Text(
                                                          'male'.tr,
                                                          style: AppTheme.lightStyle(
                                                              color:Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    value: 'male',
                                                    groupValue: controller
                                                        .selectedGender,
                                                    activeColor:
                                                   Colors.white,
                                                    onChanged: (value) {
                                                      controller
                                                          .selectedGender =
                                                          value;
                                                      controller
                                                          .genderController
                                                          .text =
                                                          value.toString().tr;
                                                      controller.update();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: AnimatedOpacity(
                                            opacity:
                                            controller.isOpenGender ? 1 : 0,
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            child: Visibility(
                                              visible: controller.isOpenGender,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 18.0),
                                                child: RadioTheme(
                                                  data: RadioThemeData(
                                                    overlayColor:
                                                    MaterialStateProperty
                                                        .all(Colors.white),
                                                    fillColor:
                                                    MaterialStateProperty
                                                        .all(Colors.white),
                                                  ),
                                                  child: RadioListTile(
                                                    contentPadding:
                                                    const EdgeInsets.all(0),
                                                    title: Row(
                                                      children: [
                                                        Text(
                                                          'female'.tr,
                                                          style: AppTheme.lightStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    value: 'female',
                                                    groupValue: controller
                                                        .selectedGender,
                                                    activeColor:
                                                   Colors.white,
                                                    onChanged: (value) {
                                                      controller
                                                          .selectedGender =
                                                          value;
                                                      controller
                                                          .genderController
                                                          .text =
                                                          value.toString().tr;
                                                      controller.update();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 8),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: TextFormField(
                        //           cursorColor:Colors.white,
                        //           onTap: () {
                        //             FocusScope.of(context)
                        //                 .requestFocus(new FocusNode());
                        //             controller.isOpenMaterial =
                        //             !controller.isOpenMaterial;
                        //             controller.update();
                        //           },
                        //           readOnly: true,
                        //           keyboardType: TextInputType.name,
                        //           textAlign: TextAlign.center,
                        //           controller: controller.materialController,
                        //           textDirection: TextDirection.ltr,
                        //           style: AppTheme.lightStyle(
                        //               color:Colors.white),
                        //           decoration: InputDecoration(
                        //               filled: true,
                        //               fillColor: Colors.transparent,
                        //               contentPadding:
                        //               const EdgeInsets.symmetric(
                        //                   vertical: 20),
                        //               suffixIcon: Padding(
                        //                 padding: const EdgeInsets.symmetric(
                        //                     horizontal: 26.0),
                        //                 child: Icon(
                        //                   controller.isOpenMaterial
                        //                       ? Icons.keyboard_arrow_up_outlined
                        //                       : Icons
                        //                       .keyboard_arrow_down_outlined,
                        //                   color:Colors.white,
                        //                 ),
                        //               ),
                        //               prefixIcon: Padding(
                        //                 padding: const EdgeInsets.symmetric(
                        //                     horizontal: 26.0),
                        //                 child: Icon(
                        //                   controller.isOpenMaterial
                        //                       ? Icons.keyboard_arrow_up_outlined
                        //                       : Icons
                        //                       .keyboard_arrow_down_outlined,
                        //                   color: Colors.transparent,
                        //                 ),
                        //               ),
                        //               border: OutlineInputBorder(
                        //                   borderRadius:
                        //                   BorderRadius.circular(100),
                        //                   borderSide: const BorderSide(
                        //                       color:Colors.white,
                        //                       width: 2)),
                        //               enabledBorder: OutlineInputBorder(
                        //                   borderRadius:
                        //                   BorderRadius.circular(100),
                        //                   borderSide: const BorderSide(
                        //                       color:Colors.white,
                        //                       width: 2)),
                        //               focusedBorder: OutlineInputBorder(
                        //                   borderRadius:
                        //                   BorderRadius.circular(100),
                        //                   borderSide: const BorderSide(
                        //                       color:Colors.white,
                        //                       width: 2)),
                        //               hintText: 'status_st'.tr,
                        //               alignLabelWithHint: true,
                        //               counter: Container(
                        //                 height: 0,
                        //               ),
                        //               hintTextDirection: TextDirection.ltr,
                        //               hintStyle: AppTheme.lightStyle(
                        //                   color:Colors.white)),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 4),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 25.0,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         child: Expanded(
                        //           child: AnimatedContainer(
                        //             duration: const Duration(milliseconds: 400),
                        //             height: controller.isOpenMaterial
                        //                 ? MediaQuery.of(context).size.height *
                        //                 0.07
                        //                 : 0,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color:Colors.white,
                        //                     width: 2),
                        //                 borderRadius:
                        //                 BorderRadius.circular(100),
                        //                 color: Colors.transparent),
                        //             child: Row(
                        //               children: [
                        //                 Expanded(
                        //                   child: AnimatedOpacity(
                        //                     opacity:
                        //                     controller.isOpenMaterial ? 1 : 0,
                        //                     duration: const Duration(
                        //                         milliseconds: 1000),
                        //                     child: Visibility(
                        //                       visible: controller.isOpenMaterial,
                        //                       child: Padding(
                        //                         padding:
                        //                         const EdgeInsets.symmetric(
                        //                             horizontal: 18.0),
                        //                         child: RadioTheme(
                        //                           data: RadioThemeData(
                        //                             overlayColor:
                        //                             MaterialStateProperty
                        //                                 .all(AppTheme
                        //                                 .colorAccent),
                        //                             fillColor:
                        //                             MaterialStateProperty
                        //                                 .all(AppTheme
                        //                                 .colorAccent),
                        //                           ),
                        //                           child: RadioListTile(
                        //                             contentPadding:
                        //                             const EdgeInsets.all(0),
                        //                             title: Row(
                        //                               children: [
                        //                                 Text(
                        //                                   'single'.tr,
                        //                                   style: AppTheme.lightStyle(
                        //                                       color: AppTheme
                        //                                           .colorAccent),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                             value: 'single',
                        //                             groupValue: controller
                        //                                 .selectedMaterialState,
                        //                             activeColor:
                        //                            Colors.white,
                        //                             onChanged: (value) {
                        //                               controller
                        //                                   .selectedMaterialState =
                        //                                   value;
                        //                               controller
                        //                                   .materialController
                        //                                   .text =
                        //                                   value.toString().tr;
                        //                               controller.update();
                        //                             },
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                   child: AnimatedOpacity(
                        //                     opacity:
                        //                     controller.isOpenMaterial ? 1 : 0,
                        //                     duration: const Duration(
                        //                         milliseconds: 1000),
                        //                     child: Visibility(
                        //                       visible: controller.isOpenMaterial,
                        //                       child: Padding(
                        //                         padding:
                        //                         const EdgeInsets.symmetric(
                        //                             horizontal: 18.0),
                        //                         child: RadioTheme(
                        //                           data: RadioThemeData(
                        //                             overlayColor:
                        //                             MaterialStateProperty
                        //                                 .all(AppTheme
                        //                                 .colorAccent),
                        //                             fillColor:
                        //                             MaterialStateProperty
                        //                                 .all(AppTheme
                        //                                 .colorAccent),
                        //                           ),
                        //                           child: RadioListTile(
                        //                             contentPadding:
                        //                             const EdgeInsets.all(0),
                        //                             title: Row(
                        //                               children: [
                        //                                 Text(
                        //                                   'married'.tr,
                        //                                   style: AppTheme.lightStyle(
                        //                                       color: AppTheme
                        //                                           .colorAccent),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                             value: 'married',
                        //                             groupValue: controller
                        //                                 .selectedMaterialState,
                        //                             activeColor:
                        //                            Colors.white,
                        //                             onChanged: (value) {
                        //                               controller
                        //                                   .selectedMaterialState =
                        //                                   value;
                        //                               controller
                        //                                   .materialController
                        //                                   .text =
                        //                                   value.toString().tr;
                        //                               controller.update();
                        //                             },
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 12),
                        Hero(
                          tag: 'buttonNext',
                          child: GestureDetector(
                            onTap: () {
                              print('assaas');
                              if (controller.formKey.currentState!.validate()) {
                                controller.save();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.colorAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'save'.tr,
                                    style: AppTheme.lightStyle(
                                      color: Colors.white,
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
                )),
          ],
        ),
      ),
    );
  }
}
