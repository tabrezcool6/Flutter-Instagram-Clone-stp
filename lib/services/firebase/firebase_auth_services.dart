// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/UserData.dart';
import 'package:instagram_clone/services/firebase/firebase_storage_methods.dart';

class FirebaseAuthServices {
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///
  /// Sign Up using Firebase Method
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Something went wrong...';
    try {
      ///
      /// Create a User in Database
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///
      /// Store Profile Pic in the DataBase
      String photoUrl = await FirebaseStorageMethods()
          .uploadImage('profilePics', file, false);

      UserData userData = UserData(
        uId: cred.user!.uid,
        username: username,
        email: email,
        bio: bio,
        followers: [],
        following: [],
        photoUrl: photoUrl,
      );

      ///
      /// Store User Data in Database
      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(userData.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ///
  /// Login Method
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'Something went wrong...';

    try {
      //
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      //
      res = e.toString();
    }

    return res;
  }

  Future<UserData> getUserData() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserData.fromSnap(snap);
  }
}
