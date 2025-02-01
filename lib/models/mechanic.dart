import 'package:cloud_firestore/cloud_firestore.dart';

class Mechanic {
  final String name;
  final String specialization;
  final String imagePath;
  final String description;

  Mechanic({
    required this.name,
    required this.specialization,
    required this.imagePath,
    required this.description,
  });

  toJson() {
    return {
      'name': name,
      'specialization': specialization,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory Mechanic.fromDoc(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return Mechanic(
        name: data?['name'],
        specialization: data?['specialization'],
        description: data?['description'],
        imagePath: data?['imagePath']);
  }
}
