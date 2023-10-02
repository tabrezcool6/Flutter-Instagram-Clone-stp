import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/models/UserData.dart';
import 'package:instagram_clone/services/firebase/firebase_auth_services.dart';

class UserProvider extends ChangeNotifier {
  UserData? _userData;

  UserData get getUserData => _userData!;

  Future<void> refreshUserData() async {
    UserData userData = await FirebaseAuthServices().getUserData();
    _userData = userData;
    notifyListeners();
  }
}
