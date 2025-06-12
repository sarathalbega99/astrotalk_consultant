import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../screens.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;
  final List<Widget> screens = <Widget>[
    ConsultantHome(),
    CallLogsScreen(),
    PayoutsScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        backgroundColor: AppColors.primaryColor,
        title: "Astrology",
        weight: FontWeight.bold,
        titleColor: AppColors.textPrimary,
        action: [
          IconButton(
            onPressed: () {
              navigateTo(context, AppRoutes.notificationScreen);
            },
            icon: Icon(
              Icons.notification_add_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_rounded),
            label: 'Activity',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Payouts'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
