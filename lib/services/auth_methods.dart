import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentoru/models/user.dart' as model;
import 'package:mentoru/services/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // Register
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String nameSurname,
      required String occupation,
      required String locaiton,
      required Uint8List imageUrl}) async {
    String response = "Some error ocured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          nameSurname.isNotEmpty ||
          locaiton.isNotEmpty ||
          occupation.isNotEmpty ||
          imageUrl.isNotEmpty) {
        //regiter user
        // ignore: unused_local_variable
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // ignore: avoid_print
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', imageUrl, false);

        model.User user = model.User(
          occupation: occupation,
          location: locaiton,
          email: email,
          bio: "",
          image: photoUrl,
          star: [],
          uid: cred.user!.uid,
          username: username,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        response = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = "E-posta formatı yanlış";
      } else if (e.code == "weak-password") {
        response = "Şifre en az 6 karaktere sahip olmalıdır";
      } else if (e.code == "email-already-in-use") {
        response = "Kullanıcı zaten var";
      }
      // ignore: avoid_print
      print(e.code);
    } catch (e) {
      //response = e.toString();
    }

    return response;
  }

  // Login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
