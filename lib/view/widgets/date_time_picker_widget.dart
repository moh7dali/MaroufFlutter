import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:Marouf/viewmodel/cart_viewmodel.dart';

import '../../models/schedule_times.dart';
import '../../utils/helper.dart';
import '../../utils/theme/app_theme.dart';

class DateTimePickerWidget extends StatefulWidget {
  DateTimePickerWidget(this.controller, {Key? key}) : super(key: key);
  CartViewModel controller;

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  final dateFormat = DateFormat('dd-MM-yyyy');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _kItemExtent = 40;
    return Container(
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(1000)),
              height: 5,
              width: Get.width * .20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'selectDeliveryTime'.tr,
              style: AppTheme.lightStyle(color: Colors.black),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Directionality(
              textDirection: cupertino.TextDirection.ltr,
              child: DropdownButton<DateWithTime>(
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                menuMaxHeight: Get.height * .5,
                underline: Container(
                  height: 0,
                ),
                hint: Center(child: Text('selectDate'.tr)),
                value: widget.controller.selectedDate,
                items: widget.controller.scheduleTimes!.data!
                    .map((DateWithTime value) {
                  return DropdownMenuItem<DateWithTime>(
                    value: value,
                    child:
                    Center(child: Text(getDateString(value.scheduleDate!))),
                  );
                }).toList(),
                onChanged: (_) {
                  setState(() {
                    widget.controller.selectedDate = _;
                    if(widget.controller.selectedDate!.timesList!.isEmpty){
                      widget.controller.selectedTime=null;
                    }else {
                      widget.controller.selectedTime = widget.controller.selectedDate!.timesList?[0];
                    }
                    widget.controller.update();
                  });
                },
              ),
            ),
          ),
          if (widget.controller.selectedDate != null)
            SizedBox(
              height: Get.height * .15,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoPicker(
                  magnification: 1.25,
                  squeeze: 1.25,
                  useMagnifier: true,
                  itemExtent: _kItemExtent,
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      widget.controller.selectedTime=widget.controller.selectedDate!.timesList![selectedItem];
                      widget.controller.update();
                      print(widget.controller.selectedDate!.timesList![selectedItem]);
                      print("+++++++++++++++++++");
                      print(selectedItem);
                    });
                  },
                  children: widget.controller.selectedDate!.timesList!.isEmpty
                      ? List<Widget>.generate(
                      1, (index) => Center(child: Text("NoAvailableTimes".tr)))
                      :
                  List<Widget>.generate(widget.controller.selectedDate!.timesList!.length, (int index) {
                    return Center(
                      child: Text(
                          parseDuration( widget.controller.selectedDate!.timesList![index]).toString()
                      ),
                    );
                  }),
                ),
              ),
            ),
          // Card(
          //   margin: EdgeInsets.all(16),
          //   elevation: 3,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10)),
          //   child: DropdownButton<String>(
          //     isExpanded: true,
          //     borderRadius: BorderRadius.circular(10),
          //     menuMaxHeight: Get.height * .5,
          //     alignment: Alignment.center,
          //     underline: Container(
          //       height: 0,
          //     ),
          //     hint: Center(child: Text('selectTime'.tr)),
          //     value: widget.controller.selectedTime,
          //     items: widget.controller.selectedDate!.timesList!
          //         .map((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Center(
          //             child: Text(
          //               parseDuration(value).toString(),
          //             )),
          //       );
          //     }).toList(),
          //     onChanged: (_) {
          //       setState(() {
          //         widget.controller.selectedTime = _;
          //         widget.controller.update();
          //       });
          //     },
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              if (widget.controller.selectedDate != null &&
                  widget.controller.selectedTime != null) {
                widget.controller.orderDate = DateFormat('dd-MM-yyyy HH:mm').parse(
                    '${widget.controller.selectedDate?.scheduleDate} ${widget.controller.selectedTime}');
                widget.controller.update();
                Get.back();
              } else {
                Helper().errorSnackBar('selectDeliveryTime'.tr, isTop: true);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
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
              height: 20
          )
        ],
      ),
    );
  }

  String parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    Duration d = Duration(hours: hours, minutes: minutes, microseconds: 000);
    String finalTime =
    DateFormat.jm().format(DateFormat("hh:mm:ss").parse(d.toString()));
    return finalTime
        .toLowerCase();
    // .replaceAll('am', 'am'.tr)
    // .replaceAll('pm', 'pm'.tr);
  }

  String getDateString(String s) {
    DateTime d = DateFormat('dd-MM-yyyy').parse(s);
    if (d.day == DateTime.now().day && d.month == DateTime.now().month) {
      return 'today'.tr;
    } else {
      return dateFormat.format(d);
    }
  }
}
