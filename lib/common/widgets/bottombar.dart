import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/features/accounts/screen/account_screen.dart';
import 'package:amazone_clone/features/homescreen/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottombarwidth = 42;
  double bootombaritemwidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text('Cart Page'),
    )
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedNavBarColor,
        unselectedItemColor: GlobalVariable.unselectedNavBarColor,
        backgroundColor: GlobalVariable.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarwidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariable.selectedNavBarColor
                              : GlobalVariable.backgroundColor,
                          width: bootombaritemwidth))),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarwidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariable.selectedNavBarColor
                              : GlobalVariable.backgroundColor,
                          width: bootombaritemwidth))),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarwidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariable.selectedNavBarColor
                              : GlobalVariable.backgroundColor,
                          width: bootombaritemwidth))),
              child: const badge.Badge(
                  badgeContent: Text('2'),
                  badgeStyle: badge.BadgeStyle(
                    badgeColor: Colors.white,
                    elevation: 0,
                  ),
                  child: Icon(Icons.shopping_cart_outlined)),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
