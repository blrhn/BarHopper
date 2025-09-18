import 'package:bar_hop/core/router/routes.dart';
import 'package:bar_hop/features/find/find_view.dart';
import 'package:bar_hop/features/home_view/home_view.dart';
import 'package:bar_hop/features/my_beers/my_beers_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/nav_bar/nav_bar.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _findNavigatorKey = GlobalKey<NavigatorState>();
  static final _myBeersNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _findNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.find,
                builder: (context, state) => const FindView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _myBeersNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.myBeers,
                builder: (context, state) => const MyBeersView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _goRouter;
}
