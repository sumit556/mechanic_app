import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/models/appointment.dart';
import 'package:medi_connect/pages/auth_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class WidgetsFlutterBinding {
}

class Firebase {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Appointment(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ), 
    );
  }
}


// const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AuthPage(),
//     );