import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/models/mechanic.dart';
import 'package:medi_connect/services/auth_services.dart';

class Appointment extends ChangeNotifier {
  List<Mechanic> mechanicShop = [
    Mechanic(
      name: 'Aanchal Chhetri',
      specialization: 'Tire Repair',
      description: 'She is good at fixing tires',
      imagePath: 'lib/img/tire.jpg',
    ),
    Mechanic(
      name: 'Bishnukant Pandit',
      specialization: 'Battery Specialist',
      description: 'He make sures battery health and longevity.',
      imagePath: 'lib/img/battery.png',
    ),
    Mechanic(
      name: 'Yangchen Lhamo',
      specialization: 'Transmission Head',
      description: 'Take care of transmission and vehicle gear shift',
      imagePath: 'lib/img/transmission.png',
    ),
    Mechanic(
      name: 'Udit Mahato',
      specialization: 'Vehicle Servicing',
      description: 'He can handle servicing of whole vehicle',
      imagePath: 'lib/img/mechanic-round.png',
    ),
  ];

  // list of appointments
  List<Mechanic> userAppointment = [];

  List<Mechanic> getMechanicList() {
    return mechanicShop;
  }

  // get user appointment
  List<Mechanic> getUserAppointment() {
    return userAppointment;
  }

  // add appointment
  void addAppointment(Mechanic mechanic) async {
    userAppointment.add(mechanic);
    await AuthServices.addAppointment(mechanic);
    notifyListeners();
  }

  // remove appointment
  void removeAppointment(Mechanic mechanic) {
    userAppointment.remove(mechanic);
    notifyListeners();
  }
}

// class AppointmentModel {
//   final String name;
//   final String specialization;
//   final String description;
//   final String imagePath;
//
//   AppointmentModel(
//       {required this.name,
//       required this.specialization,
//       required this.description,
//       required this.imagePath});
//
//   toJson() {
//     return {
//       'name': name,
//       'specialization': specialization,
//       'description': description,
//       'imagePath': imagePath,
//     };
//   }
//
//   factory AppointmentModel.fromDoc(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     return AppointmentModel(
//         name: data?['name'],
//         specialization: data?['specialization'],
//         description: data?['description'],
//         imagePath: data?['imagePath']);
//   }
// }
