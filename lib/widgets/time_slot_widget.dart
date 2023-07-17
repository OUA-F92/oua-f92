import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentoru/utils/colors.dart';

import '../models/time_model.dart';

class TimeSlotWidget extends StatefulWidget {
  late DateTime dateTime = DateTime(0);
  TimeSlotWidget({super.key});

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  static final now = DateTime.now();
  DateTime selectedTime = DateTime(0);

  List<TimeModel> timeSlots = [
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 9, 0, 0),
      isBooked: true,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 10, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 10, 0, 0),
      isBooked: true,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 11, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 11, 0, 0),
      isBooked: false,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 12, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 12, 0, 0),
      isBooked: false,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 13, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 13, 0, 0),
      isBooked: false,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 14, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 14, 0, 0),
      isBooked: false,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 15, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 15, 0, 0),
      isBooked: true,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 16, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 16, 0, 0),
      isBooked: false,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 17, 0, 0),
    ),
    TimeModel(
      startTime: DateTime(now.year, now.month, now.day, 17, 0, 0),
      isBooked: true,
      isSelected: false,
      endTime: DateTime(now.year, now.month, now.day, 18, 0, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 9,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemBuilder: (BuildContext context, int index) {
        var time = DateFormat.Hm().format(timeSlots[index].startTime);
        var color = lightWhiteColor;
        return GestureDetector(
          onTap: () {
            // setState(() {
            //   if (!timeSlots[index].isBooked) {
            //     for (int i = 0; i < timeSlots.length; i++) {
            //       timeSlots[i].isSelected = false;
            //     }
            //     timeSlots[index].isSelected = !timeSlots[index].isSelected;
            //     widget.dateTime = timeSlots[index].startTime;
            //     print(widget.dateTime);
            //   }
            // });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Get.width * 0.04),
                border: Border.all(color: timeSlots[index].isBooked || timeSlots[index].isSelected ? Colors.transparent : Colors.black),
                color: timeSlots[index].isSelected ? greenColor : Colors.transparent),
            child: Center(
                child: Text(
              time,
              style: TextStyle(color: timeSlots[index].isBooked ? darkGrayColor : Colors.black),
            )),
          ),
        );
      },
    );
  }
}
