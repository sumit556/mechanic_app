import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medi_connect/models/mechanic.dart';
import 'package:medi_connect/services/user_data.dart';

import '../models/user_model.dart';

class AuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final userRepo = Get.put(UserData());

  static Future<User?> registerUser(UserModel users) async {
    final userCred = await auth.createUserWithEmailAndPassword(
        email: users.email, password: users.password);
    await userRepo.createUser(users);
    final user = userCred.user;
    return user;
  }

  static Future<User?> getUser(String email, String password) async {
    final userCred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCred.user;
    return user;
  }

  static void signingOut() async {
    await auth.signOut();
  }

  static getUserData() {
    final email = auth.currentUser?.email;
    if (email != null) {
      return userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Inside getUserData');
    }
  }

  static updateUser(UserModel user) async {
    await userRepo.updateUser(user);
  }

  static addAppointment(Mechanic mechanic) async {
    final email = auth.currentUser?.email;
    String? uid = '';
    if (email != null) {
      final user = await userRepo.getUserDetails(email);
      uid = user.uid;
    } else {
      Get.snackbar('Error', 'Inside getUserData');
    }
    await userRepo.createAppointment(mechanic, uid);
  }

  static deleteAppointment(Mechanic mechanic) async {
    final email = auth.currentUser?.email;
    String? uid = '';
    if (email != null) {
      final user = await userRepo.getUserDetails(email);
      uid = user.uid;
    } else {
      Get.snackbar('Error', 'Inside getUserData');
    }
    await userRepo.deleteAppointment(mechanic.name, uid);
  }
}
