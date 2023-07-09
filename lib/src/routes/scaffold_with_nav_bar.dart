import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/routes/app_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  final Widget child;
  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;
  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      context.goNamed(AppRoute.notes.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.favNotes.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.account.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      body: Container(
        child: widget.child,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
            color: WordieConstants.mainColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            unselectedItemColor: WordieConstants.backgroundColor2,
            selectedItemColor: WordieConstants.backgroundColor,
            onTap: (index) => _tap(context, index),
            // type: BottomNavigationBarType.shifting,
            backgroundColor: WordieConstants.mainColor,
            items: const [
              BottomNavigationBarItem(
                  label: 'Dashboard', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'favourites', icon: Icon(Icons.favorite)),
              BottomNavigationBarItem(
                  label: 'Account', icon: Icon(Icons.account_circle_sharp))
            ]),
      ),
    );
  }
}
