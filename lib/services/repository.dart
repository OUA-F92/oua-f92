import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentoru/models/categories_model.dart';

class Repository {
  Future<Categories> getCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot snap = await firestore.collection("categories").doc("Teknoloji").get();
    return Categories.fromSnap(snap);
  }
}
