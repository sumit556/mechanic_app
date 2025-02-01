import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:medi_connect/models/appointment.dart';
import 'package:medi_connect/models/mechanic.dart';

import '../models/user_model.dart';

class UserData extends GetxController {
  static UserData get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(UserModel users) async {
    try {
      final collection = _db.collection("users");

      final ref = await collection.add(users.toJson()).whenComplete(() {
        EasyLoading.showToast(
          'Success Your account has been created.',
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      });

      await ref.update({'uid': ref.id});
    } catch (error) {
      if (kDebugMode) {
        print('Error:${error.toString()}');
      }
      EasyLoading.showError(
        '$error thrown',
      );
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromDoc(e)).single;
    return userData;
  }

  updateUser(UserModel user) async {
    try {
      await _db
          .collection("users")
          .doc(user.uid)
          .update(user.toJson())
          .whenComplete(() {
        EasyLoading.showToast('Success your account has been updated.',
            toastPosition: EasyLoadingToastPosition.bottom);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Errorwhileupdating:${error.toString()}');
      }
    }
  }

  createAppointment(Mechanic mechanic, String? uid) async {
    try {
      await _db
          .collection("users")
          .doc(uid)
          .collection("appointments")
          .add(mechanic.toJson());
    } catch (error) {
      if (kDebugMode) {
        print('Error:${error.toString()}');
      }
      EasyLoading.showError(
        '$error thrown',
      );
    }
  }

  deleteAppointment(String name, String? uid) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .doc(uid)
          .collection("appointments")
          .where('name', isEqualTo: name)
          .get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error:${error.toString()}');
      }
      EasyLoading.showError(
        '$error thrown',
      );
    }
  }
}
