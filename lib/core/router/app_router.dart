import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/find/domain/presentation/find_view.dart';
import '../../features/home_view/home_view.dart';
import '../../features/my_beers/my_beers_view.dart';
import '../../features/nav_bar/nav_bar.dart';
import '../../features/pubs/domain/entities/pub.dart';
import '../../features/pubs/domain/presentation/pub_review.dart';
import '../../features/pubs/domain/presentation/pub_view.dart';
import 'routes.dart';

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
      GoRoute(
        path: "${Routes.pub}/:id",
        builder: (context, state) {
          final pub = state.extra as Pub;
          return PubView(pub: pub);
        },
      ),
      GoRoute(
        path: "${Routes.pubReview}/:id",
        builder: (context, state) {
          final extra = state.extra!;

          return switch (extra) {
            Pub _ => PubReview(pub: extra),
            Map<String, dynamic> _ => PubReview(
              pub: extra["pub"],
              review: extra["review"],
            ),
            _ => HomeView(),
          };
        },
      ),
    ],
  );

  static GoRouter get router => _goRouter;
}
