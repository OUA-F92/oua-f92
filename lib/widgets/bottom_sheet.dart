import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/appointments_model.dart';
import '../models/time_model.dart';
import '../models/user.dart' as model;
import '../ui/discover/widgets/stars_widget.dart';
import '../utils/colors.dart';
import 'custom_button_widget.dart';
import 'custom_text_field.dart';
import 'title_text_widget.dart';

Future<void> AppointmentBottomSheet(BuildContext context, DocumentSnapshot<Object?> snap) {
  late DateTime dateTime = DateTime(0);

  final now = DateTime.now();

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

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.4,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  snap["username"],
                                  style: TextStyle(fontSize: Get.width / 20, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  snap["occupation"],
                                  style: const TextStyle(color: darkGrayColor),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              snap['image'],
                            ),
                            radius: Get.width / 12,
                          ),
                        ],
                      ),
                      const StarsWidget(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: TitleTextWidget(
                          title: "Hakkında",
                        ),
                      ),
                      Text(
                        snap["bio"],
                        style: TextStyle(color: darkGrayColor),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: TitleTextWidget(
                          title: "E-posta",
                        ),
                      ),
                      Text(snap["email"]),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: TitleTextWidget(
                          title: "Saat",
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 9,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                        itemBuilder: (BuildContext context, int index) {
                          var time = DateFormat.Hm().format(timeSlots[index].startTime);
                          var color = lightWhiteColor;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!timeSlots[index].isBooked) {
                                  for (int i = 0; i < timeSlots.length; i++) {
                                    timeSlots[i].isSelected = false;
                                  }
                                  timeSlots[index].isSelected = !timeSlots[index].isSelected;
                                  dateTime = timeSlots[index].startTime;
                                  print(dateTime);
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Get.width * 0.04),
                                  border: Border.all(
                                      color: timeSlots[index].isBooked || timeSlots[index].isSelected ? Colors.transparent : Colors.black),
                                  color: timeSlots[index].isSelected ? greenColor : Colors.transparent),
                              child: Center(
                                  child: Text(
                                time,
                                style: TextStyle(color: timeSlots[index].isBooked ? darkGrayColor : Colors.black),
                              )),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomButton(
                          isBorder: false,
                          isFilled: true,
                          onTap: () async {
                            User? currentUser = FirebaseAuth.instance.currentUser;
                            String userId = currentUser?.uid ?? '';
                            var userSnap =
                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

                            var date = Timestamp.fromDate(dateTime.toLocal()) as Timestamp;

                            AppointmentModel appointment = AppointmentModel(
                              id: '',
                              title: "online konferans",
                              dateTime: date,
                              createdByUserId: userId,
                              assignedToUserId: snap["uid"],
                              assignedToUserName: snap["username"],
                            );

                            addAppointmentToFirestore(appointment);
                          },
                          child: Center(
                              child: Text(
                            "Kaydet",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: Get.width / 24),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

Future<void> addAppointmentToFirestore(AppointmentModel appointment) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('appointments').add(appointment.toFirestore());
    Get.snackbar("randuvu oluşturuldu", "başarılı");
    print("success");
    // Randevu ekleme işlemi başarılı.
  } catch (e) {
    print(e.toString());
  }
}
