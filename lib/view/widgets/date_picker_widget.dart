import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/theme/app_theme.dart';

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget(this.textController, this.controller, {Key? key})
      : super(key: key);

  TextEditingController textController;
  GetxController controller;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.colorAccent,
                  borderRadius: BorderRadius.circular(1000)),
              height: 5,
              width: Get.width * .20,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoDatePicker(
                initialDateTime: widget.textController.text.isNotEmpty
                    ? dateFormat.parse(widget.textController.text)
                    : DateTime.now(),
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  setState(() {
                    widget.textController.text = dateFormat.format(value);
                    widget.controller.update();
                  });
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
    color: AppTheme.colorAccent, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'next'.tr,
                    style: AppTheme.lightStyle(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
