import 'package:clean/core/widgets/app_empty_state.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/showcase/presentation/pages/widgets_showcase_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../di/injection.dart';
import '../navigation/navigation_service.dart';

final appRouter = GoRouter(
  navigatorKey: getIt<NavigationService>().navigatorKey,
  initialLocation: SplashPage.routeName,
  routes: [
    GoRoute(path: SplashPage.routeName, name: SplashPage.routeName, builder: (context, state) => const SplashPage()),
    GoRoute(path: WidgetsShowcasePage.routeName, name: WidgetsShowcasePage.routeName, builder: (context, state) => const WidgetsShowcasePage()),
    GoRoute(path: LoginPage.routeName, name: LoginPage.routeName, builder: (context, state) => const LoginPage()),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: AppEmptyState.empty(icon: Icons.error, title: 'Page not found: ${state.uri}'),
  ),
);
