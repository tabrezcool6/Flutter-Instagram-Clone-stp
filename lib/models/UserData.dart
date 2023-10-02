// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uId;
  final String username;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  UserData({
    required this.uId,
    required this.username,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'uid': uId,
        'username': username,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl
      };

  static UserData fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return UserData(
      uId: data['uid'],
      username: data['username'],
      email: data['email'],
      bio: data['bio'],
      followers: data['followers'],
      following: data['following'],
      photoUrl: data['photoUrl'],
    );
  }
}
