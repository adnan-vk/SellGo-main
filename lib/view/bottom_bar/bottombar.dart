import 'package:authentication/controller/bottom_provider/bottom_prov.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/bottom_bar/chatlist/chat_list.dart';
import 'package:authentication/view/bottom_bar/favourites/favourites.dart';
import 'package:authentication/view/bottom_bar/home_screen/home.dart';
import 'package:authentication/view/bottom_bar/profile/profile.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final List tabs = [
    HomeScreen(),
    Favourites(),
    ChatList(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BottomProvider>(context);
    return Scaffold(
      body: tabs[pro.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colors().blue,
        unselectedItemColor: colors().black,
        elevation: 9,
        currentIndex: pro.currentIndex,
        onTap: (index) => pro.onTabTapped(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.home_outline),
            activeIcon: Icon(EneftyIcons.home_bold),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.heart_outline),
            activeIcon: Icon(EneftyIcons.heart_bold),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.message_outline),
            activeIcon: Icon(EneftyIcons.message_bold),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.profile_circle_outline),
            activeIcon: Icon(EneftyIcons.profile_circle_bold),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
