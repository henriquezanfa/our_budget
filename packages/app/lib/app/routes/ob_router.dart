import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/app/view/app_with_navbar.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_account_details_page.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_accounts_list_page.dart';
import 'package:ob/features/categories/presentation/categories_page.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_card_details_page.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_cards_list_page.dart';
import 'package:ob/features/features.dart';
import 'package:ob/features/login/presentation/login.dart';
import 'package:ob/features/manage/presentation/ui/manage_page.dart';
import 'package:ob/features/profile/presentation/ui/profile_page.dart';
import 'package:ob/features/registration/registration.dart';
import 'package:ob/features/space/presentation/space_details_screen.dart';
import 'package:ob/features/space/presentation/space_handler.dart';
import 'package:ob/features/splash/splash.dart';
import 'package:ob/features/transactions/presentation/add_transaction_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final _historyNavigatorKey = GlobalKey<NavigatorState>();
final _accountsNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: OBRoutes.root,
  navigatorKey: _rootNavigatorKey,
  observers: [
    NavigatorObserver(),
  ],
  routes: [
    GoRoute(
      path: OBRoutes.root,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: OBRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: OBRoutes.registration,
      builder: (context, state) => const RegistrationPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return SpaceHandler(child: AppWithNavbar(child: child));
      },
      branches: [
        // Each branch represents a tab in the bottom navigation bar
        // or the login page if the user is not authenticated
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              redirect: (context, state) {
                final user = FirebaseAuth.instance.currentUser;
                // FirebaseAuth.instance.signOut();
                if (user == null) {
                  return OBRoutes.login;
                }

                return null;
              },
              path: OBRoutes.home,
              builder: (context, state) => const HomePage(),
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
              path: OBRoutes.manage,
              builder: (context, state) => const ManagePage(),
            ),
            GoRoute(
              path: OBRoutes.bankAccountDetails,
              pageBuilder: (context, state) => _modalTransitionBuilder(
                BankAccountDetailsPage(
                  bankAccount: state.extra! as BankAccount,
                ),
              ),
            ),
            GoRoute(
              path: OBRoutes.bankAccounts,
              builder: (context, state) => const BankAccountsListPage(),
            ),
            GoRoute(
              path: OBRoutes.categories,
              builder: (context, state) => const CategoriesPage(),
            ),
            GoRoute(
              path: OBRoutes.creditCards,
              builder: (context, state) => const CreditCardsListPage(),
            ),
            GoRoute(
              path: OBRoutes.creditCardDetails,
              builder: (context, state) => CreditCardDetailsPage(
                creditCard: state.extra! as CreditCard,
              ),
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
            GoRoute(
              path: OBRoutes.spaceDetails,
              builder: (context, state) => const SpaceDetailsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: OBRoutes.addTransaction,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (_, __) =>
          _modalTransitionBuilder(const AddTransactionPage()),
    ),
  ],
);

MaterialPage<T> _modalTransitionBuilder<T>(
  Widget child,
) {
  return MaterialPage(
    child: child,
    fullscreenDialog: true,
  );
}

// navigator observer to reset the state of the nested navigators
class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == OBRoutes.root) {
      _homeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
      _historyNavigatorKey.currentState?.popUntil((route) => route.isFirst);
      _accountsNavigatorKey.currentState?.popUntil((route) => route.isFirst);
      _profileNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }
}
