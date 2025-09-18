import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/nav_bar_config.dart';

class NavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: _destinations(),
        onDestinationSelected: _goBranch,
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  List<NavigationDestination> _destinations() {
    return NavBarEnum.values
        .map(
          (navEnum) => (NavigationDestination(
            icon: Icon(navEnum.icon),
            label: navEnum.label,
          )),
        )
        .toList();
  }
}
