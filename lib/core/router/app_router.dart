import 'package:clean/core/di/injection.dart';
import 'package:clean/core/navigation/navigation_service.dart';
import 'package:clean/core/widgets/app_empty_state.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:clean/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:clean/features/splash/presentation/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  navigatorKey: getIt<NavigationService>().navigatorKey,
  initialLocation: SplashPage.routeName,
  redirect: (context, state) async {
    final authRepository = getIt<AuthRepository>();
    final isAuthenticated = await authRepository.isAuthenticated();
    
    final isOnSplash = state.matchedLocation == SplashPage.routeName;
    final isOnLogin = state.matchedLocation == LoginPage.routeName;

    // If authenticated and trying to access login/splash, redirect to dashboard
    if (isAuthenticated && (isOnLogin || isOnSplash)) {
      return DashboardPage.routeName;
    }

    // If not authenticated and trying to access protected routes, redirect to login
    if (!isAuthenticated && !isOnLogin && !isOnSplash) {
      return LoginPage.routeName;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: SplashPage.routeName,
      name: SplashPage.routeName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.routeName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: DashboardPage.routeName,
      name: DashboardPage.routeName,
      builder: (context, state) => const DashboardPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: AppEmptyState.empty(
      icon: Icons.error,
      title: 'Page not found: ${state.uri}',
    ),
  ),
);
