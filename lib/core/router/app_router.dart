import 'package:clean/core/di/injection.dart';
import 'package:clean/core/navigation/navigation_service.dart';
import 'package:clean/core/widgets/app_empty_state.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:clean/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:clean/features/home/presentation/view/pokemon_detail_page.dart';
import 'package:clean/features/splash/presentation/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  navigatorKey: getIt<NavigationService>().navigatorKey,
  initialLocation: SplashPage.routeName,
  redirect: (context, state) async {
    final isOnSplash = state.matchedLocation == SplashPage.routeName;
    if (isOnSplash) return null;

    final isAuthenticated = await getIt<AuthRepository>().isAuthenticated();
    final isOnLogin = state.matchedLocation == LoginPage.routeName;

    if (!isAuthenticated && !isOnLogin) return LoginPage.routeName;
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
      routes: [
        // Deep link: clean://app/pokemon/25  or  https://clean.ashiish.space/dashboard/pokemon/25
        GoRoute(
          path: 'pokemon/:id',
          name: 'pokemon-detail',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return PokemonDetailPage(pokemonId: id);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: AppEmptyState.empty(
      icon: Icons.error,
      title: 'Page not found: ${state.uri}',
    ),
  ),
);
