import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;
  final String bio;
  final List star;
  final String image;
  final String occupation;
  final String location;

  User(
      {required this.occupation,
      required this.location,
      required this.email,
      required this.bio,
      required this.image,
      required this.star,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "star": star,
        "image": image,
        "occupation": occupation,
        "location": location
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      occupation: snapshot["occupation"],
      location: snapshot["location"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      image: snapshot["image"],
      star: snapshot["star"],
      uid: snapshot["uid"],
      username: snapshot["username"],
    );
  }
}
