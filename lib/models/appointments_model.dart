import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String title;
  final Timestamp dateTime;
  final String createdByUserId;
  final String assignedToUserId;
  final String assignedToUserName;

  AppointmentModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.createdByUserId,
    required this.assignedToUserId,
    required this.assignedToUserName,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      id: doc.id,
      title: data['title'],
      dateTime: data['dateTime'],
      createdByUserId: data['createdByUserId'],
      assignedToUserId: data['assignedToUserId'],
      assignedToUserName: '',
    );
  }

  Map<String, dynamic> toFirestore() => {
        "id": id,
        'title': title,
        'dateTime': dateTime,
        'createdByUserId': createdByUserId,
        "assignedToUserId": assignedToUserId,
        "assignedToUserName": assignedToUserName,
      };
}
