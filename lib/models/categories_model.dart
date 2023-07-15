import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  final String name;
  final String imageUrl;

  Categories({required this.name, required this.imageUrl});

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
      };

  static Categories fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Categories(
      name: snapshot["name"],
      imageUrl: snapshot["imageUrl"],
    );
  }
}
