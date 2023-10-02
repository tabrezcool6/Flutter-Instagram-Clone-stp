import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  /// Upload Image to DataBase Method
  Future<String> uploadImage(String child, Uint8List file, bool isPost) async {
    ///
    /// Create a Refernce to store in desired child folder
    Reference ref =
        _firebaseStorage.ref().child(child).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
