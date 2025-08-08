import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/router/routes.dart';
import 'package:yolla/src/data/models/order/order_model.dart';
import 'package:yolla/src/presentation/history/views/history_view.dart';
import 'package:yolla/src/presentation/main/presentation/main_view.dart';
import 'package:yolla/src/presentation/profile/views/profile_view.dart';
import 'package:yolla/src/presentation/qr/views/qr_view.dart';
import 'package:yolla/src/presentation/sale/views/sale_view.dart';
import 'package:yolla/src/presentation/checkout/checkout_view.dart';
import 'package:yolla/src/presentation/history/views/order_details_view.dart';

import 'auth_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.signInView,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => MainView(child: child),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.qrView,
                pageBuilder: (context, state) => NoTransitionPage(child: QrView()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.saleView,
                pageBuilder: (context, state) => NoTransitionPage(child: SaleView()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.historyView,
                pageBuilder: (context, state) => NoTransitionPage(child: HistoryView()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profileView,
                pageBuilder: (context, state) => NoTransitionPage(child: ProfileView()),
              ),
            ],
          ),
        ],
      ),
      // Checkout route
      GoRoute(
        path: Routes.checkoutView,
        pageBuilder: (context, state) {
          final products = state.extra;
          return MaterialPage(
            child: CheckoutView(),
          );
        },
      ),
      // Order details route
      GoRoute(
        path: Routes.orderDetailsView,
        pageBuilder: (context, state) {
          final order = state.extra as OrderModel;
          return MaterialPage(
            child: OrderDetailsView(order: order),
          );
        },
      ),
      ...authRoutes,
    ],
  );
}
