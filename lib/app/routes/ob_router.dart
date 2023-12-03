import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/app/view/app_with_navbar.dart';
import 'package:ob/app/view/auth_handler_page.dart';
import 'package:ob/features/cards/presentation/ui/accounts_page.dart';
import 'package:ob/features/features.dart';
import 'package:ob/features/login/presentation/login.dart';
import 'package:ob/features/profile/presentation/ui/profile_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final _historyNavigatorKey = GlobalKey<NavigatorState>();
final _accountsNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: OBRoutes.root,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: OBRoutes.root,
      builder: (context, state) => const AuthHandlerPage(),
    ),
    GoRoute(
      path: OBRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return AppWithNavbar(child: child);
      },
      branches: [
        // Each branch represents a tab in the bottom navigation bar
        // or the login page if the user is not authenticated
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: OBRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: OBRoutes.counter,
              builder: (context, state) => const CounterPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _historyNavigatorKey,
          routes: [
            GoRoute(
              path: OBRoutes.history,
              builder: (context, state) => const HistoryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _accountsNavigatorKey,
          routes: [
            GoRoute(
              path: OBRoutes.accounts,
              builder: (context, state) => const AccountsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: OBRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
