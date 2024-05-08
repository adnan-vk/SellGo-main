import 'package:authentication/controller/bottom_provider/bottom_prov.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/add_item/additem.dart';
import 'package:authentication/view/favourites/favourites.dart';
import 'package:authentication/view/home_screen/home.dart';
import 'package:authentication/view/profile/profile.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final List tabs = [
    HomeScreen(),
    Favourites(),
    AddItem(),
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
            icon: Icon(EneftyIcons.add_square_outline),
            activeIcon: Icon(EneftyIcons.add_square_bold),
            label: 'Add Item',
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
