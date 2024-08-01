import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_scan/features/home/view/home_screen.dart';
import 'package:id_card_scan/features/home/view/upload_id_screen.dart';
import 'route_constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    routes: <RouteBase>[
      // home route
      GoRoute(
        path: Routes.home,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeScreen()),
      ),

      // upload id route
      GoRoute(
        path: Routes.upload,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: UploadIdScreen()),
      ),
    ],
  );
}
