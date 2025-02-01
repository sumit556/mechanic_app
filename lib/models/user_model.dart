import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String email;
  final String password;
  final String? profile;

  UserModel(
      {this.uid, required this.email, required this.password, this.profile});

  toJson() {
    return {
      'uid': uid,
      "Email": email,
      "password": password,
      "profile": profile,
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      uid: document.id,
      email: data["Email"],
      password: data["password"],
      profile: data['profile'],
    );
  }
}
