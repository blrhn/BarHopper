import 'package:bar_hop/core/router/routes.dart';
import 'package:bar_hop/features/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: ShellRoute for NavBar
// https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    routes: [
      GoRoute(path: Routes.home, builder: (context, state) => const HomeView()),
    ],
  );

  static GoRouter get router => _goRouter;
}
