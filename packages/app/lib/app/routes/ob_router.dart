import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/app/view/app_with_navbar.dart';
import 'package:ob/domain/models/money_transaction/money_transaction.dart';
import 'package:ob/features/bank_accounts/domain/model/bank_account.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_account_details_page.dart';
import 'package:ob/features/bank_accounts/presentation/ui/pages/bank_accounts_list_page.dart';
import 'package:ob/features/categories/presentation/categories_page.dart';
import 'package:ob/features/credit_cards/domain/model/credit_card.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_card_details_page.dart';
import 'package:ob/features/credit_cards/presentations/ui/pages/credit_cards_list_page.dart';
import 'package:ob/features/features.dart';
import 'package:ob/features/home/view/home_view.dart';
import 'package:ob/features/intro/intro_page.dart';
import 'package:ob/features/login/presentation/login.dart';
import 'package:ob/features/manage/presentation/ui/manage_page.dart';
import 'package:ob/features/onboarding/presentation/ui/create_bank_accounts_page.dart';
import 'package:ob/features/onboarding/presentation/ui/create_categories_page.dart';
import 'package:ob/features/onboarding/presentation/ui/create_space_page.dart';
import 'package:ob/features/onboarding/presentation/ui/loading_page.dart';
import 'package:ob/features/onboarding/presentation/ui/onboarding_page.dart';
import 'package:ob/features/profile/presentation/ui/profile_page.dart';
import 'package:ob/features/registration/registration.dart';
import 'package:ob/features/space/presentation/space_details_screen.dart';
import 'package:ob/features/splash/splash.dart';
import 'package:ob/features/transactions/presentation/upsert_transaction_view.dart';

class CustomRouter {
  CustomRouter() {
    _router = _getRouter();
  }

  late GoRouter _router;
  GoRouter get router => _router;

  void refresh() {
    _router = _getRouter();
  }

  GoRouter _getRouter() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final homeNavigatorKey = GlobalKey<NavigatorState>();

    final profileNavigatorKey = GlobalKey<NavigatorState>();
    final historyNavigatorKey = GlobalKey<NavigatorState>();
    final accountsNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      initialLocation: OBRoutes.root,
      navigatorKey: rootNavigatorKey,
      observers: [NavigatorObserver()],
      routes: [
        GoRoute(
          path: OBRoutes.root,
          pageBuilder: (context, state) =>
              _fadeTransitionBuilder(const SplashPage()),
        ),
        GoRoute(
          path: OBRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: OBRoutes.registration,
          builder: (context, state) => const RegistrationPage(),
        ),
        GoRoute(
          path: OBRoutes.addTransaction,
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (_, state) => _modalTransitionBuilder(
            UpsertTransactionView(
              transaction: state.extra as MoneyTransaction?,
            ),
          ),
        ),
        GoRoute(
          path: OBRoutes.onboarding,
          pageBuilder: (context, state) => _fadeTransitionBuilder(
            const OnboardingPage(),
          ),
          routes: [
            GoRoute(
              path: OBRoutes.createSpace,
              pageBuilder: (context, state) => _fadeTransitionBuilder(
                const CreateSpacePage(),
              ),
            ),
            GoRoute(
              path: OBRoutes.createBankAccounts,
              pageBuilder: (context, state) => _fadeTransitionBuilder(
                const CreateBankAccountsPage(),
              ),
            ),
            GoRoute(
              path: OBRoutes.createCategories,
              pageBuilder: (context, state) => _fadeTransitionBuilder(
                const CreateCategoriesPage(),
              ),
            ),
            GoRoute(
              path: OBRoutes.loading,
              pageBuilder: (context, state) => _fadeTransitionBuilder(
                const LoadingPage(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: OBRoutes.intro,
          pageBuilder: (context, state) => _fadeTransitionBuilder(
            const IntroPage(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) =>
              _fadeTransitionBuilder(
            AppWithNavbar(child: navigationShell),
          ),
          builder: (context, state, child) {
            return AppWithNavbar(child: child);
          },
          branches: [
            // Each branch represents a tab in the bottom navigation bar
            // or the login page if the user is not authenticated
            StatefulShellBranch(
              navigatorKey: homeNavigatorKey,
              routes: [
                GoRoute(
                  path: OBRoutes.home,
                  redirect: (context, state) {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      return OBRoutes.intro;
                    }

                    return null;
                  },
                  builder: (context, state) => const HomeView(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: historyNavigatorKey,
              routes: [
                GoRoute(
                  path: OBRoutes.history,
                  builder: (context, state) => const HistoryPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: accountsNavigatorKey,
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
              navigatorKey: profileNavigatorKey,
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
      ],
    );
  }

  static Page<T> _modalTransitionBuilder<T>(
    Widget child,
  ) {
    return MaterialPage(
      child: child,
      fullscreenDialog: true,
    );
  }

  /// only animate the opacity of the page
  static Page<T> _fadeTransitionBuilder<T>(
    Widget child,
  ) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
