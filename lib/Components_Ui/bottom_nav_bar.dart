import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.black,
        activeColor: Colors.white,
        tabActiveBorder: Border.all(color:Colors.white),
        tabBackgroundColor: const Color.fromARGB(255, 57, 138, 149),
        tabBorderRadius: 35,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
        GButton(
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: Icons.calendar_month_rounded,
          text: 'Appointments',
        ),
        GButton(
          icon: Icons.account_circle_rounded,
          text: 'Profile',
        ),
      ]),
    );
  }
}
