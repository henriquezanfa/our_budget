import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/app/view/app_with_navbar.dart';
import 'package:ob/features/auth/presentation/auth_page.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_account_details_page.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_accounts_list_page.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_card_details_page.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_cards_list_page.dart';
import 'package:ob/features/features.dart';
import 'package:ob/features/login/presentation/login.dart';
import 'package:ob/features/manage/presentation/ui/manage_page.dart';
import 'package:ob/features/profile/presentation/ui/profile_page.dart';
import 'package:ob/features/registration/registration.dart';
import 'package:ob/features/splash/splash.dart';
import 'package:ob/features/transactions/presentation/transaction_page.dart';

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
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: OBRoutes.auth,
      builder: (context, state) => const AuthPage(),
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
              builder: (context, state) => BankAccountDetailsPage(
                bankAccount: state.extra! as BankAccount,
              ),
            ),
            GoRoute(
              path: OBRoutes.bankAccounts,
              builder: (context, state) => const BankAccountsListPage(),
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
          ],
        ),
      ],
    ),
    GoRoute(
      path: OBRoutes.transaction,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const MaterialPage(
          fullscreenDialog: true,
          child: TransactionPage(),
        );
      },
    ),
  ],
);
