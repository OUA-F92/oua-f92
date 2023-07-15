import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 12, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime, orangeColor, "Diana Septini"));
    meetings.add(Meeting('Conference', startTime, endTime, purpleColor, "Diana Septini"));
    meetings.add(Meeting('Conference', DateTime(today.year, today.month, today.day, 15, 0, 0),
        DateTime(today.year, today.month, today.day, 15, 0, 0).add(const Duration(hours: 2)), purpleColor, "Diana Septini"));

    return meetings;
  }

  List colorList = [purpleColor, orangeColor, Color(0xff82d964), Color(0xffe665fd), Color(0xfff7980b), Color(0xfffc6054)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SfCalendar(
        headerHeight: 0,
        view: CalendarView.day,
        showCurrentTimeIndicator: true,
        todayHighlightColor: orangeColor,
        onTap: (calendarTapDetails) {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      SizedBox(
                        width: Get.width,
                        height: Get.width / 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text('Katıl'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Meeting appointment = calendarAppointmentDetails.appointments.first;
          final color = colorList[Random().nextInt(6)];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text(
                    appointment.eventName,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    appointment.user,
                    style: TextStyle(color: lightWhiteColor, fontSize: Get.width / 30),
                  ),
                ]),
              ),
            ),
          );
        },
        timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 9,
            endHour: 21,
            timeFormat: "h:mm",
            timeInterval: Duration(hours: 1),
            timeIntervalHeight: 50,
            timeIntervalWidth: 200),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: greenColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.none),
      ),
    ));
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.user);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String user;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  Color getUser(int index) {
    return appointments![index].user;
  }
}
