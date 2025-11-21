import 'package:flutter/material.dart';
import 'package:sky_message/Utils/AppColors/app_colors.dart';
import 'package:sky_message/View/Screen/BottomNav/account_info_screen.dart';
import 'package:sky_message/View/Screen/BottomNav/user_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    UserListPage(),
    AccountInfoScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _screens[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: AppColors.blackColor,
        selectedItemColor:Colors.blue,
        type: BottomNavigationBarType.fixed,
      onTap: (index){

        setState(() {
          currentIndex=index;
        });



      },
        items: [
      BottomNavigationBarItem(icon: Icon(Icons.message),label: "Message"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "Person"),
    ]),

    );
  }
}
