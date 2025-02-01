import 'package:flutter/material.dart';

import '../Components_Ui/circular_avatar_widget.dart';
import '../models/user_model.dart';
import '../services/auth_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FutureBuilder(
          future: AuthServices.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No user data found'));
            }

            UserModel? details = snapshot.data as UserModel?;
            user = details;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularAvatarWidget(
                  radius: 100,
                  existingImage: details?.profile,
                ),
                Text(
                  "Email: ${details?.email}",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
